# Request external-network ID by name
data "openstack_networking_network_v2" "external_net" {
  name = "external-network"
}

# Creating a router
resource "openstack_networking_router_v2" "router_tf" {
  name = "router_tf"
  external_network_id = data.openstack_networking_network_v2.external_net.id
}

# Creating a network
resource "openstack_networking_network_v2" "network_tf" {
  name = "network_tf"
}

# Creating a subnet
resource "openstack_networking_subnet_v2" "subnet_tf" {
  network_id = openstack_networking_network_v2.network_tf.id
  name = "subnet_tf"
  cidr = var.subnet_cidr
}

# Connecting the router to the subnet
resource "openstack_networking_router_interface_v2" "router_interface_tf" {
  router_id = openstack_networking_router_v2.router_tf.id
  subnet_id = openstack_networking_subnet_v2.subnet_tf.id
}
