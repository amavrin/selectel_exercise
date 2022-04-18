# Cloud Platform Region
variable "region" {
  default = "ru-3"
}

# Availability Zone
variable "az_zone" {
  default = "ru-3b"
}

# Type of the network volume that the server is created from
variable "volume_type" {
  default = "fast.ru-3b"
}

# Subnet CIDR
variable "subnet_cidr" {
  default = "10.10.0.0/24"
}

# tfuser's password, set in env var
variable "selectel_tform_passwd" {
}

# Managed servers count
variable "server_count" {
  default = 3
}

# Private key file
variable "private_key_file" {
  default = "~/.ssh/selectel_id_rsa"
}


# Below are variables which are not normally required to change
variable "work_server_volume_size" {
  default = "5"
}

variable "management_server_volume_size" {
  default = "5"
}

variable "work_server_ram_size" {
  default = "1024"
}

variable "work_server_cpu_count" {
  default = "1"
}

variable "management_server_ram_size" {
  default = "1024"
}

variable "management_server_cpu_count" {
  default = "1"
}

variable "server_os" {
  default = "Ubuntu 20.04 LTS 64-bit"
}
