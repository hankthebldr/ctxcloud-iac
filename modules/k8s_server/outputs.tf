output "private_ip" {
  description = "Private IP of the Kubernetes server"
  value       = aws_instance.k8s_server.private_ip
}