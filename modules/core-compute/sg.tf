## ---------- Security Group ----------

resource "aws_security_group" "allow_requirements_sg" {
    name = "allow_requirements"
    description = "SG to allow SSH inbound traffic and outbound traffic"
    vpc_id = aws_vpc.main_vpc.id

    tags = {
        Name = "ssh_https_http"
    }
}

## ---------- Security Rules ----------

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_in" {
  security_group_id = aws_security_group.allow_requirements_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_in" {
  security_group_id = aws_security_group.allow_requirements_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_in" {
  security_group_id = aws_security_group.allow_requirements_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_out" {
  security_group_id = aws_security_group.allow_requirements_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
