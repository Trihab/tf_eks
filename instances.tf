## Deploy VPC, Network Configuration, Security groups and EC2 instance
module "core-compute" {
  source         = "./modules/core-compute"
  image_id       = data.aws_ami.ami_search.id
  vm_type        = "t2.micro"
  instance_count = 1
}