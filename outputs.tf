output "instance_group_manager" {
  description = "The instance group manager for the managed instance group"
  value       = module.instance_group.instance_group_manager
}

output "load_balancer_ip" {
  description = "The IP address of the load balancer"
  value       = module.load_balancer.global_address
}
