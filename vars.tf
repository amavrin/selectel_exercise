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
