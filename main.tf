/* provider "vsphere" {
  user                              = var.vsphere_user
  password                    = var.vsphere_password
  vsphere_server          = var.vsphere_server
  allow_unverified_ssl = true
} */

resource "vsphere_tag_category" "category" {
  name        = "terraform-category"
  cardinality = "SINGLE"
  description = "Managed by Terraform"

  associable_types = [
    "VirtualMachine"
  ]
}

resource "vsphere_tag" "tag" {
  name        = "terraform-tag"
  category_id = "${vsphere_tag_category.category.id}"
  description = "Managed by Terraform"
}

resource vsphere_virtual_machine "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.compute_cluster.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vmfolder
  num_cpus = var.cpu_number
  memory                 = var.ram_size
  guest_id = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  cdrom {
    client_device = true
  }

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  wait_for_guest_net_timeout = 0

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  vapp {
    properties ={
      #hostname = var.hostname
      user-data = base64encode(templatefile("${path.module}/templates/kickstart.tpl",
    {
      hostname           = var.hostname
      fqdn               = var.hostname
      ssh_key            = var.ssh_keys
      password = var.password
    }))
    }
  }
  extra_config = {
    "guestinfo.metadata" = base64encode(templatefile("${path.module}/templates/metadata.json.tpl", {
      hostname = var.hostname
      network_config = base64encode(templatefile("${path.module}/templates/metadata.tpl", {
        hostname = var.hostname
        ipv4_subnet_mask = var.ipv4_subnet_mask
        ipv4             = var.ipv4
        ipv4_gateway     = var.ipv4_gateway
        nameservers      = var.nameservers
      }))
    }))
    "guestinfo.metadata.encoding" = "base64"
    # "guestinfo.userdata"          = base64encode(file("${path.module}/cloud-config/centos7.yaml"))
    # "guestinfo.userdata.encoding" = "base64"
  }
}
