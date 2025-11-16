## Fetch AMI id ex: aws ec2 describe-images --image-ids ami-0c7d68785ec07306c --query "Images[0].owner" --output text
data "aws_ami" "ami_search" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.9.20251110.1-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["137112412989"]
}

## Deploy VPC, Network Configuration, Security groups and EC2 instance
module "core-compute" {
  source         = "./modules/core-compute"
  image_id       = data.aws_ami.ami_search.id
  vm_type        = "t2.micro"
  instance_count = 1
}

## Deploy EKS

module "eks_cluster" {
  source = "./modules/eks-cluster"
}

## Deploy IAM Role to a service

## Deploy LB