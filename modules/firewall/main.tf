resource "aws_instance" "firewall" {
  ami           = var.fw_ami
  instance_type = var.fw_instance_type
  key_name      = var.key_name
  tags = {
    Name = "pan-ngfw"
  }

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.mgmt.id
  }

  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.untrust.id
  }

  network_interface {
    device_index         = 2
    network_interface_id = aws_network_interface.trust.id
  }
}

resource "aws_network_interface" "mgmt" {
  subnet_id   = var.public_subnet_id
  description = "Management Interface"
  tags = {
    Name = "fw-mgmt"
  }
}

resource "aws_network_interface" "untrust" {
  subnet_id   = var.public_subnet_id
  description = "Untrust Interface"
  source_dest_check = false
  tags = {
    Name = "fw-untrust"
  }
}

resource "aws_network_interface" "trust" {
  subnet_id   = var.private_subnet_id
  description = "Trust Interface"
  source_dest_check = false
  tags = {
    Name = "fw-trust"
  }
}

resource "aws_eip" "mgmt_ip" {
  vpc               = true
  network_interface = aws_network_interface.mgmt.id
}