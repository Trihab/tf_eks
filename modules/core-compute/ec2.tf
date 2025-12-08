## Create EC2 Instance
resource "aws_instance" "ec2" {
  ami                         = var.image_id
  instance_type               = var.vm_type
  count                       = var.instance_count
  vpc_security_group_ids      = [aws_security_group.allow_requirements_sg.id]
  subnet_id                   = aws_subnet.subnet_public_a.id
  associate_public_ip_address = "true"
  key_name                    = "ec2_priv_key"
  user_data                   = <<-EOF
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

## ---- SSH ----

resource "tls_private_key" "ssh_keygen" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh_keypair" {
  key_name   = "ec2_priv_key"
  public_key = tls_private_key.ssh_keygen.public_key_openssh
}

resource "local_file" "out_priv_key" {
  content         = tls_private_key.ssh_keygen.private_key_pem
  filename        = "${aws_key_pair.ssh_keypair.key_name}.pem"
  file_permission = "0600"
}