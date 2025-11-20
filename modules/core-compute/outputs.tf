output "eip_out" {
  value = aws_eip.eip_nat.public_ip
  sensitive = false
}