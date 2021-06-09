# openstack
variable "user_name" {}
variable "password" {}
variable "tenant_name" {}
variable "auth_url" {}

# openstack_compute_keypair_v2
variable "import_public_key_name" {}
variable "public_key" {}

# openstack_compute_instance_v2
locals {
  instance = {
    test01 = {
      image_name      = "vmi-centos-7.9-amd64"
      flavor_name     = "g-c2m1d100"
      security_groups = ["gncs-ipv4-ssh", "gncs-ipv4-web"]
    },
    test02 = {
      image_name      = "vmi-centos-7.9-amd64"
      flavor_name     = "g-c2m1d100"
      security_groups = ["gncs-ipv4-ssh", "gncs-ipv4-web"]
    },
    test03 = {
      image_name      = "vmi-centos-7.9-amd64"
      flavor_name     = "g-c2m1d100"
      security_groups = ["gncs-ipv4-ssh", "gncs-ipv4-web"]
    },
  }
}
