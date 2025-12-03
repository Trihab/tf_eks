# Fetch VPC and Subnets informations
data "aws_vpc" "selected" {
  tags = {
    "Name" = "main_vpc"
  }

  depends_on = [ module.core-compute ]
}

data "aws_subnets" "my_public_subnets_ids" {
  filter {
    name = "vpc-id"
    values = [ data.aws_vpc.selected.id ]
  }

  tags = {
    "Class" = "Public"
  }
}

data "aws_subnets" "my_private_subnets_ids" {
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
    subnet_ids = concat(data.aws_subnets.my_private_subnets_ids.ids,data.aws_subnets.my_public_subnets_ids.ids)
  }

  depends_on = [ aws_iam_role_policy_attachment.eks_cluster_policy ]
}

resource "aws_eks_node_group" "eks_node_ec2" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "t2_micro-node_group"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = data.aws_subnets.my_private_subnets_ids.ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
  
  ami_type       = "AL2023_x86_64_STANDARD"
  instance_types = ["t2.micro"]
  capacity_type  = "ON_DEMAND"
  disk_size      = 20
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_ro,
    aws_iam_role_policy_attachment.eks_cni_policy
  ]

}