resource "aws_security_group" "allow_http_lb" {
  name        = "allow_http_lb"
  description = "SG to allow http inbound traffic and outbound traffic"
  vpc_id      = module.core-compute.vpc_id

  tags = {
    Name = "http_lb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_in" {
  security_group_id = aws_security_group.allow_http_lb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_out" {
  security_group_id = aws_security_group.allow_http_lb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group_rule" "allow_lb_nodes" {
  description = "Allow LB to forward traffic to EKS Nodes"
  type        = "ingress"

  from_port = 30080
  to_port   = 30080
  protocol  = "tcp"

  source_security_group_id = aws_security_group.allow_http_lb.id
  security_group_id        = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
}