resource "local_file" "ssh_config" {
  content = templatefile("templates/ssh_config.tftpl",
    {
      work_servers: openstack_compute_instance_v2.work_server,
      management_server: openstack_compute_instance_v2.management_server,
      work_server_ips: openstack_networking_floatingip_v2.work_server_fip,
      management_server_ip: openstack_networking_floatingip_v2.management_server_fip,
      server_count: var.server_count,
      private_key_file: var.private_key_file,
    },
  )
  filename = "files/ssh_config"
  file_permission = "0644"
}
