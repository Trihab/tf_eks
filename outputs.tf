output "ec2_ip" {
  value     = module.core-compute.ec2_ippub
  sensitive = false
}

output "coredns_version" {
  value = data.aws_eks_addon_version.latest_coredns.version
}

output "vpccni_version" {
  value = data.aws_eks_addon_version.latest_vpccni.version
}

output "kubeproxy_version" {
  value = data.aws_eks_addon_version.latest_kubeproxy.version
}

output "lb_url" {
  value = aws_lb.app_lb.dns_name
}