# Fetch VPC and Subnets informations
data "aws_vpc" "selected" {
  tags = {
    "Name" = "main_vpc"
  }
}

data "aws_subnets" "my_subnets_ids" {
  filter {
    name = "vpc-id"
    values = [ data.aws_vpc.selected.id ]
  }

  tags = {
    "Class" = "Private"
  }
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.34"

  vpc_config {
    subnet_ids = data.aws_subnets.my_subnets_ids.ids
  }

  depends_on = [ aws_iam_role_policy_attachment.eks_cluster_policy ]
}