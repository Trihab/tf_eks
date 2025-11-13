## Create EC2 Instance
resource "aws_instance" "ec2" {
  ami           = var.image_id
  instance_type = var.vm_type
  count         = var.instance_count

  tags = {
    Name = "JacksBlogExample"
  }
}