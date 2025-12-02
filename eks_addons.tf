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

resource "aws_eks_addon" "eks_ao_coredns" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "coredns"
  addon_version               = data.aws_eks_addon_version.latest_coredns.version
  resolve_conflicts_on_update = "PRESERVE"
  depends_on = [ aws_eks_node_group.eks_node_ec2 ]
}

resource "aws_eks_addon" "eks_ao_vpc-cni" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "vpc-cni"
  addon_version               = data.aws_eks_addon_version.latest_vpccni.version
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "eks_ao_kubeproxy" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "kube-proxy"
  addon_version               = data.aws_eks_addon_version.latest_kubeproxy.version
  resolve_conflicts_on_update = "PRESERVE"
}