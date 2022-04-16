terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 1.43.0"
    }
     selectel = {
      source = "selectel/selectel"
      version = "~> 3.6.2"
   }
  }
}

provider "openstack" {
  auth_url = "https://api.selvpc.ru/identity/v3"
  domain_name = "211025"
  tenant_id = "4c1c6c4b96e24be6bb2c48083b19236f"
  user_name = "tform"
  password = var.selectel_tform_passwd
  region = var.region
}
