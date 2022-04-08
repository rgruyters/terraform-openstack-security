output "security_group_id" {
  description = "The ID of the security group"
  value       = try(openstack_networking_secgroup_v2.this[0].id, "")
}

# vim: ft=tf
