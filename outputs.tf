output "firewall_mgmt_ip" {
  description = "Public IP of the firewall management interface"
  value       = module.firewall.mgmt_ip
}

output "k8s_server_private_ip" {
  description = "Private IP of the Kubernetes server"
  value       = module.k8s_server.private_ip
}

output "honeypot_private_ip" {
  description = "Private IP of the honeypot instance"
  value       = module.honeypot.private_ip
}