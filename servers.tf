# Searching for the image ID (that the server will be created from) by its name
data "openstack_images_image_v2" "ubuntu_image" {
  most_recent = true
  visibility = "public"
  name = "Ubuntu 20.04 LTS 64-bit"
}

# Creating a server configuration with 1 vCPU and 1 GB RAM
# Parameter  disk = 0  makes the network volume a boot one
resource "openstack_compute_flavor_v2" "server_flavor" {
  name = "server-1"
  ram = "1024"
  vcpus = "1"
  disk = "0"
  is_public = "false"
}

# Creating a 5 GB network boot volume from the image
resource "openstack_blockstorage_volume_v3" "server_volume" {
  count = var.server_count
  name = "volume-for-server-{count.index}"
  size = "5"
  image_id = data.openstack_images_image_v2.ubuntu_image.id
  volume_type = var.volume_type
  availability_zone = var.az_zone
  enable_online_resize = true
  lifecycle {
    ignore_changes = [image_id]
  }
}

# Creating a server
resource "openstack_compute_instance_v2" "server_tf" {
  count = var.server_count
  name = "server-${count.index}"
  flavor_id = openstack_compute_flavor_v2.server_flavor.id
  key_pair = openstack_compute_keypair_v2.key_tf.id
  availability_zone = var.az_zone
  network {
    uuid = openstack_networking_network_v2.network_tf.id
  }
  block_device {
    uuid = openstack_blockstorage_volume_v3.server_volume[count.index].id
    source_type = "volume"
    destination_type = "volume"
    boot_index = 0
  }
  vendor_options {
    ignore_resize_confirmation = true
  }
  lifecycle {
    ignore_changes = [image_id]
  }
}

# Creating a floating IP
resource "openstack_networking_floatingip_v2" "fip_tf" {
  count = var.server_count
  pool = "external-network"
}

# Associating the floating IP to the server
resource "openstack_compute_floatingip_associate_v2" "fip_tf" {
  count = var.server_count
  floating_ip = openstack_networking_floatingip_v2.fip_tf[count.index].address
  instance_id = openstack_compute_instance_v2.server_tf[count.index].id
}
