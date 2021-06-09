terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}

provider "openstack" {
  user_name   = var.user_name
  password    = var.password
  tenant_name = var.tenant_name
  auth_url    = var.auth_url
}

resource "openstack_compute_keypair_v2" "import_public_key" {
  name       = var.import_public_key_name
  public_key = var.public_key
}

resource "openstack_compute_instance_v2" "create_vps_instance" {
  for_each = local.instance

    name            = each.key
    image_name      = each.value.image_name
    flavor_name     = each.value.flavor_name
    security_groups = each.value.security_groups
    key_pair        = openstack_compute_keypair_v2.import_public_key.name

    lifecycle {
      ignore_changes = [name]
    }

    metadata = {
      instance_name_tag = each.key
    }
}

output "access_ip_v4" {
  value = { for k, v in openstack_compute_instance_v2.create_vps_instance : k => v.access_ip_v4 }
}
