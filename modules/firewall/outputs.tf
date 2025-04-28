output "mgmt_ip" {
  description = "Public IP of the firewall management interface"
  value       = aws_eip.mgmt_ip.public_ip
}

output "trust_eni_id" {
  description = "ID of the trust network interface"
  value       = aws_network_interface.trust.id
}