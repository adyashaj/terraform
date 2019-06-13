variable "count" {
  default = 1
}
resource "openstack_compute_instance_v2" "web" {
  count = "${var.count}"
  name = "ubuntu_ansible_fromserver"
  image_name = "CloudInitImage_proxyEnabled"
  availability_zone = "nova:fire"
  flavor_id = "00b81a2c-a32a-4219-8060-4e7f3f8a9b26"
  security_groups = ["default"]
  network {
    name = "proj_0001"
  }
provisioner "local-exec" {
    command = "sleep 50 && echo \"[webserver]\n${openstack_networking_floatingip_v2.fip_1.address} ansible_connection=ssh ansible_ssh_user=tcs ansible_password=tcs\" > inventory &&  ansible-playbook -i inventory testplaybook.yml"
  }
}

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "public"
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
  instance_id = "${openstack_compute_instance_v2.web.id}"
}


