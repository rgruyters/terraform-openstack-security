provider "openstack" {}

module "main_sg" {
  source = "../../"

  name          = "main-sg"
  ingress_cidr  = "10.20.30.0/24"
  ingress_rules = ["ssh-tcp"]
  tags          = ["staging"]
}

module "complete_sg" {
  source = "../../"

  name          = "complete-sg"
  ingress_with_cidr_blocks = [
    {
      rule       = "postgresql-tcp"
      cidr_block = "0.0.0.0/0"
    },
    {
      rule       = "postgresql-tcp"
      cidr_block = "30.30.30.30/32"
    },
    {
      from_port   = 10
      to_port     = 20
      protocol    = 6
      description = "Service name"
      cidr_block  = "10.10.0.0/20"
    },
  ]
  tags          = ["staging"]
}

# vim: ft=tf
