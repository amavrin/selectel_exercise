# SSH key to access the cloud server
variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+83z21i49YtLaYAVLmcqGy1XuKwLrBVQ/u7hmOnQUNX+aEt1oOXysZ3sA/1p6WXt3s72vz/855P2eNyE0ive9wYrsJPrqAC4JlCIEA97kIwkTIaZc6sDtep/h0nGTEnw2p+Lof6SLUljJj/FQ9ndttZvE+jetklQrbpEPxafUlOsLc1kyQDS8Lw877aAdL/W6GCaI80LDRaaXHVDOufc5Sj0HcJNMN3SVLZ8n34GLy4t2SsqzZdoK3LpEsnrqg4W1OaaWRiEWaz3/wFsrVPiEqZt2+NNhvHuEnAans4K5KXeN/jggFAVb1yHp65ZuGobadBrVVq/va/uFrbo4Gb1kXQQfLFBTYEZWpQ3vc8CM/RYjT5YbfO+vr3H1YYJ/H8UXVlnME45NOl/ekKzWY8l0uc/a4seotXpmX3WX6ubeg0mK4eQzUwXV1+lCU8w+pf2PFmSuKL887xNYe4p4FD2utqtHncnEIenZGLdMsL7svlukUl6ADKq9Ggxdy9k/Wcc= tform"
}

# Creating the SSH key
resource "openstack_compute_keypair_v2" "key_tf" {
  name       = "key_tf"
  region     = var.region
  public_key = var.public_key
}


