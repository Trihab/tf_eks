output "eip_out" {
  value     = module.core-compute.eip_out
  sensitive = true
}

output "vpc_get" {
  value = module.eks_cluster.vpc_return
}