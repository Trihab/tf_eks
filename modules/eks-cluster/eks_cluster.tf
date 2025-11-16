# Fetch VPC and Subnets informations
data "aws_vpc" "selected" {
  tags = {
    "Name" = "main_vpc"
  }
}

data "aws_subnet_ids" "my_subnets_ids" {
  vpc_id = data.aws_vpc.selected.id
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.31"

  vpc_config {
    subnet_ids = []
  }

  depends_on = [ aws_iam_role_policy_attachment.eks_cluster_policy ]
}