resource "local_file" "ssh_config" {
  content = templatefile("templates/ssh_config.tftpl",
    {
      servers: openstack_compute_instance_v2.server_tf,
      ips: openstack_networking_floatingip_v2.fip_tf,
      server_count: var.server_count,
    },
  )
  filename = "files/ssh_config"
  file_permission = "0644"
}
