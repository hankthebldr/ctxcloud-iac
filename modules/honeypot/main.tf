resource "aws_instance" "honeypot" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  user_data = <<-EOT
    #!/bin/bash
    export DSHIELD_EMAIL="${var.dshield_email}"
    export DSHIELD_API_KEY="${var.dshield_api_key}"
    ${file("${path.module}/../../scripts/setup_honeypot.sh")}
    EOT

  tags = {
    Name = "honeypot"
  }
}