variable "count" {
  default = 1
}
resource "openstack_compute_instance_v2" "web" {
  count = "${var.count}"
  name = "${format("ubuntu_sakettest-%03d", count.index+1)}"
  image_name = "CloudInitImage_proxyEnabled"
  availability_zone = "nova"
  flavor_id = "00b81a2c-a32a-4219-8060-4e7f3f8a9b26"
#  key_pair = "${openstack_keypair}"
  security_groups = ["default"]
  network {
    name = "proj_0001"
  }
  user_data = "${file("nginx_install.sh")}"
}
