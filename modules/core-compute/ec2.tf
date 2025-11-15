## Create EC2 Instance
resource "aws_instance" "ec2" {
  ami           = var.image_id
  instance_type = var.vm_type
  count         = var.instance_count
  vpc_security_group_ids = [aws_security_group.allow_requirements_sg.id]
  subnet_id = aws_subnet.subnet_private_a.id

  tags = {
    Name = "vm-micro"
  }
}