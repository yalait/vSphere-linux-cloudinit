# ---------------------------------------------------------------------------------------------------------------------
# VMWARE PROVIDER VARIABLES
# These are used to connect to vCenter.
# ---------------------------------------------------------------------------------------------------------------------

variable "vsphere_server" {
  type = string
  description = "Адрес vsphere"
  default = "sand-vc01.lab.oncloud.ru"
}

variable "vsphere_user" {
  type = string
  description = "Имя пользователя для подключения,если домееная авторихация то требуется указывать домен. Пример: oncloud/smirnovmv"
}

variable "vsphere_password" {
  type = string
  description = "Пароль пользователя для подключения к vsphere"
  sensitive = true
}

# ---------------------------------------------------------------------------------------------------------------------
# VMWARE DATA SOURCE VARIABLES
# These are used to discover unmanaged resources used during deployment.
# ---------------------------------------------------------------------------------------------------------------------

variable "datacenter_name" {
  type        = string
  description = "Имя датацентра vSphere, в котором будут созданы ресурсы."
}

variable "cluster_name" {
  type        = string
  description = "Кластер vSphere, в котором будут созданы ресурсы."
}

variable "datastore_name" {
  type        = string
  description = "Датастор vSphere, в котором будут созданы ресурсы."
}

variable "datastore_cluster_name"{
  type    = string
  default = ""
}

variable "vm_network_name" {
  type = string
  description = "Имя Network в vsphere "
}

variable "template_name" {
  type = string
  description = "Имя темплейта из Content Libraries"
}

variable "vmrp" {
  description = "Пул ресурсов кластера, в котором будет развернута виртуальная машина. Используйте следующее, чтобы выбрать пул, умолчанию в кластере (esxi1) или (кластер)/ресурсы."
}


# ---------------------------------------------------------------------------------------------------------------------
# VMWARE RESOURCE VARIABLES
# Variables used during the creation of resources in vSphere.
# ---------------------------------------------------------------------------------------------------------------------

variable "vm_name" { 
  type = string
  description = "Имя ВМ в vsphere"
  default = "node1000"
}

variable "hostname" {
  type        = string
  default     = ""
  description = "Hostname ВМ внутри ОСи"
}

variable "nameservers" {
  type        = string
  default     = "77.88.8.8"
  description = "Адрес ДНС сервера"
}

variable "ipv4" {
  type  = string
  description = "Адрес ipv4. Пример: 192.168.1.10"
  default = "192.168.200.40"
}

variable "ipv4_subnet_mask" {
  type        = string
  description = "Маска сети. пример 24,32 и т.д."
  default     = "24"
}

variable "ipv4_gateway" {
  type        = string
  description = "Шлюз,ipv4"
  default     = "192.168.200.1"
}

variable "vmfolder" {
  type        = string
  #description = "The path to the folder to put this virtual machine in, relative to the datacenter that the resource pool is in. Path - The absolute path of the folder. For example, given a default datacenter of default-dc, a folder of type vm, and a folder name of terraform-test-folder, the resulting path would be /default-dc/vm/terraform-test-folder."
  description = "Имя директории в которой будут созданы ресуры. Пример: TestTerr"
  default     = null
}

variable "vm_disk_size" {
  type        = number
  description = "Размер диска,в ГБ"
  default     = 10
}

variable "cpu_number" {
  description = "CPUs ,по умолчанию 1"
  default     = 1
}

variable "ram_size" {
  type = number
  description = "RAM, указывать в MB"
  default     = 512
}

variable "password" {
  type        = string
  description = "Пароль для УЗ onlanta"
  default     = "123qwe"
}

/* variable "ssh_keys" {
  type        = list(any)
  description = "Открытый ключ которому разрешено подключаться к ВМ"
  default     = []
} */

variable "ssh_keys" {
  type        = string
  description = "Открытый ключ которому разрешено подключаться к ВМ"
  default     = ""
}
