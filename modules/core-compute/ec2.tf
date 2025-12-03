## Create EC2 Instance
resource "aws_instance" "ec2" {
  ami           = var.image_id
  instance_type = var.vm_type
  count         = var.instance_count
  vpc_security_group_ids = [aws_security_group.allow_requirements_sg.id]
  subnet_id = aws_subnet.subnet_public_a.id
  ebs_optimized = "true"
  associate_public_ip_address = "true"
  key_name = aws_key_pair.tp4_keypair.key_name
  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install httpd -y
    systemctl start httpd
    systemctl enable httpd
  EOF

  tags = {
    Name = "vm-micro"
  }
}

resource "tls_private_key" "tp4_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tp4_keypair" {
  key_name   = "tp4-key" 
  public_key = tls_private_key.tp4_key.public_key_openssh
}

resource "local_file" "tp4_private_key" {
  content  = tls_private_key.tp4_key.private_key_openssh
  filename = "key.pem" 
  file_permission = "0400" 
}