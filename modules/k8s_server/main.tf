resource "aws_instance" "k8s_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  user_data     = file("${path.module}/scripts/setup_k8s.sh")
  tags = {
    Name = "k8s-server"
  }
}