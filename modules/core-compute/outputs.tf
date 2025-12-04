output "ec2_ippub" {
  value = aws_instance.ec2.public_ip
  sensitive = false
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "priv_subnets_ids" {
  value = [
    aws_subnet.subnet_private_a.id,
    aws_subnet.subnet_private_b.id,
    aws_subnet.subnet_private_c.id
  ]
}

output "pub_subnets_ids" {
  value = [
    aws_subnet.subnet_public_a.id,
    aws_subnet.subnet_public_b.id,
    aws_subnet.subnet_public_c.id
  ]
}
