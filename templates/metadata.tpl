#local-hostname: ${hostname}
#instance-id: ${hostname}
network:
  version: 2
  ethernets:
    ens192:
      dhcp4: false
      addresses:
        - ${ipv4}/${ipv4_subnet_mask}
      gateway4: ${ipv4_gateway} 
      nameservers:
        addresses:
          - ${nameservers}