# Fetch VPC and Subnets informations
# data "aws_vpc" "selected" {
#   tags = {
#     "Name" = "main_vpc"
#   }

#   depends_on = [ module.core-compute ]
# }

# data "aws_subnets" "my_public_subnets_ids" {
#   filter {
#     name = "vpc-id"
#     values = [ data.aws_vpc.selected.id ]
#   }

#   tags = {
#     "Class" = "Public"
#   }
# }

# data "aws_subnets" "my_private_subnets_ids" {
#   filter {
#     name = "vpc-id"
#     values = [ data.aws_vpc.selected.id ]
#   }

#   tags = {
#     "Class" = "Private"
#   }
# }

## EKS Addons

data "aws_eks_addon_version" "latest_coredns" {
  addon_name         = "coredns"
  kubernetes_version = aws_eks_cluster.eks_cluster.version
}

data "aws_eks_addon_version" "latest_vpccni" {
  addon_name         = "vpc-cni"
  kubernetes_version = aws_eks_cluster.eks_cluster.version
}

data "aws_eks_addon_version" "latest_kubeproxy" {
  addon_name         = "kube-proxy"
  kubernetes_version = aws_eks_cluster.eks_cluster.version
}

## Fetch AMI id ex: aws ec2 describe-images --image-ids ami-0c7d68785ec07306c --query "Images[0].owner" --output text
data "aws_ami" "ami_search" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami*6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["137112412989"]
}