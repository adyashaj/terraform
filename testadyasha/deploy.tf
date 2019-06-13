variable "count" 
{
  default = 2
}
resource "openstack_compute_instance_v2" "web" 
{
  count = "${var.count}"
  name = "${format("adya_ubuntu_ngnix-%03d", count.index+1)}"
  image_name = "CloudInitImage_proxyEnabled"
  availability_zone = "nova"
  flavor_id = "00b81a2c-a32a-4219-8060-4e7f3f8a9b26"
#  key_pair = "${openstack_keypair}"
  security_groups = ["default"]
  network 
{
    name = "proj_0001"
  }
  user_data = "${file("nginx_install.sh")}"
}
resource "openstack_compute_flavor_v2" "test-flavor" {
  name  = "adyasha_my-flavor"
  ram   = "8096"
  vcpus = "2"
  disk  = "20"

  extra_specs {
    "hw:cpu_policy" = "CPU-POLICY",
    "hw:cpu_thread_policy" = "CPU-THREAD-POLICY"
  }
}


