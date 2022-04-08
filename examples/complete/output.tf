output "security_group_ids" {
  description = "The ID of the security group"
  value       = [module.main_sg.security_group_id, module.complete_sg.security_group_id]
}

# vim: ft=tf
