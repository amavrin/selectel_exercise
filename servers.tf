data "openstack_images_image_v2" "ubuntu_image" {
  most_recent = true
  visibility = "public"
  name = var.server_os
}

resource "openstack_compute_flavor_v2" "work_server_flavor" {
  name = "work_node"
  ram = var.work_server_ram_size
  vcpus = var.work_server_cpu_count
  disk = "0"
  is_public = "false"
}

resource "openstack_compute_flavor_v2" "management_server_flavor" {
  name = "management_node"
  ram = var.management_server_ram_size
  vcpus = var.management_server_cpu_count
  disk = "0"
  is_public = "false"
}

resource "openstack_blockstorage_volume_v3" "work_server_volume" {
  count = var.server_count
  name = "volume-for-work-server-{count.index}"
  size = var.work_server_volume_size
  image_id = data.openstack_images_image_v2.ubuntu_image.id
  volume_type = var.volume_type
  availability_zone = var.az_zone
  enable_online_resize = true
  lifecycle {
    ignore_changes = [image_id]
  }
}

resource "openstack_blockstorage_volume_v3" "management_server_volume" {
  name = "volume-for-management-server"
  size = var.management_server_volume_size
  image_id = data.openstack_images_image_v2.ubuntu_image.id
  volume_type = var.volume_type
  availability_zone = var.az_zone
  enable_online_resize = true
  lifecycle {
    ignore_changes = [image_id]
  }
}

# Creating a work server
resource "openstack_compute_instance_v2" "work_server" {
  count = var.server_count
  name = "server-${count.index}"
  flavor_id = openstack_compute_flavor_v2.work_server_flavor.id
  key_pair = openstack_compute_keypair_v2.key_tf.id
  availability_zone = var.az_zone
  user_data = "#cloud-config\nhostname: work-server-${count.index}"
  network {
    uuid = openstack_networking_network_v2.network_tf.id
  }
  block_device {
    uuid = openstack_blockstorage_volume_v3.work_server_volume[count.index].id
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

# Creating the management server
resource "openstack_compute_instance_v2" "management_server" {
  name = "management-server"
  flavor_id = openstack_compute_flavor_v2.management_server_flavor.id
  key_pair = openstack_compute_keypair_v2.key_tf.id
  availability_zone = var.az_zone
  user_data = "#cloud-config\nhostname: management-server"
  network {
    uuid = openstack_networking_network_v2.network_tf.id
  }
  block_device {
    uuid = openstack_blockstorage_volume_v3.management_server_volume.id
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

resource "openstack_networking_floatingip_v2" "work_server_fip" {
  count = var.server_count
  pool = "external-network"
}

resource "openstack_networking_floatingip_v2" "management_server_fip" {
  pool = "external-network"
}

resource "openstack_compute_floatingip_associate_v2" "work_server_fip_assoc" {
  count = var.server_count
  floating_ip = openstack_networking_floatingip_v2.work_server_fip[count.index].address
  instance_id = openstack_compute_instance_v2.work_server[count.index].id
}

resource "openstack_compute_floatingip_associate_v2" "management_server_fip_assoc" {
  floating_ip = openstack_networking_floatingip_v2.management_server_fip.address
  instance_id = openstack_compute_instance_v2.management_server.id
}
