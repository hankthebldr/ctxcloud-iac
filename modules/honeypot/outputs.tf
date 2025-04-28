output "private_ip" {
  description = "Private IP of the honeypot instance"
  value       = aws_instance.honeypot.private_ip
}