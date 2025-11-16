output "vpc_return" {
  value = data.aws_vpc.selected.id
}

output "sub_return" {
  value = data.aws_subnets.my_subnets_ids.ids
}