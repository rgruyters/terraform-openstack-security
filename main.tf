locals {
  this_sg_id = var.create_sg ? concat(openstack_networking_secgroup_v2.this.*.id, [""])[0] : var.security_group_id
}

resource "openstack_networking_secgroup_v2" "this" {
  count       = var.create_sg ? 1 : 0
  name        = var.name
  description = var.description
  tags        = var.tags
}

resource "openstack_networking_secgroup_rule_v2" "ingress_rules" {
  count = var.create_sg ? length(var.ingress_rules) : 0

  security_group_id = local.this_sg_id
  direction         = "ingress"
  remote_ip_prefix  = var.ingress_cidr
  ethertype         = "IPv4"

  port_range_min = var.rules[var.ingress_rules[count.index]][0]
  port_range_max = var.rules[var.ingress_rules[count.index]][1]
  protocol       = var.rules[var.ingress_rules[count.index]][2]
  description    = var.rules[var.ingress_rules[count.index]][3]
}

resource "openstack_networking_secgroup_rule_v2" "ingress_with_cidr_blocks" {
  count = var.create_sg ? length(var.ingress_with_cidr_blocks) : 0

  security_group_id = local.this_sg_id
  direction         = "ingress"
  remote_ip_prefix  = lookup(var.ingress_with_cidr_blocks[count.index], "cidr_block")
  ethertype         = "IPv4"

  port_range_min = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "from_port",
    var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][0],
  )
  port_range_max = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "to_port",
    var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][1],
  )
  protocol = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "protocol",
    var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][2],
  )
  description = lookup(
    var.ingress_with_cidr_blocks[count.index],
    "description",
    "Ingress Rule",
  )
}

# vim: ft=tf
