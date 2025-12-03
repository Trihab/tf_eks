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