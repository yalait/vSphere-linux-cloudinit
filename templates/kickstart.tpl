#cloud-config 
hostname: ${hostname}
fqdn: ${fqdn}
chpasswd: #Change your local password here
    list: |
      onlanta:${password}
    expire: false
users:
  - default #Define a default user
  - name: onlanta
    gecos: onlanta
    lock_passwd: false
    groups: sudo, users, admin
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh_authorized_keys:
      - ${ssh_keys}
system_info: 
  default_user:
    name: default-user
    lock_passwd: false
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
#disable_root: false #Enable root access
ssh_pwauth: yes #Use pwd to access (otherwise follow official doc to use ssh-keys)
random_seed:
    file: /dev/urandom
    command: ["pollinate", "-r", "-s", "https://entropy.ubuntu.com"]
    command_required: true
package_upgrade: true
packages:
  - python3-pip #Dependency package for cur
write_files:
  - path: /etc/cloud/cloud.cfg.d/90_dpkg.cfg
    owner: root:root
    permissions: "0644"
    content: |
      datasource_list: [ VMware, None ]
runcmd:
    - curl -sSL https://raw.githubusercontent.com/vmware/cloud-init-vmware-guestinfo/master/install.sh | sh - #Install cloud-init
power_state:
  timeout: 30
  mode: reboot