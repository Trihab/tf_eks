## Deploy EKS Cluster

resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.34"

  vpc_config {
    subnet_ids = concat(module.core-compute.priv_subnets_ids, module.core-compute.pub_subnets_ids)
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}

resource "aws_eks_node_group" "eks_node_ec2" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "t2_micro-node_group"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = module.core-compute.priv_subnets_ids

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