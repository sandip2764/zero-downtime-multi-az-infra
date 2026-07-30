resource "aws_security_group" "this_security_group" {
  name_prefix = var.name_prefix
  description = var.description

  vpc_id = var.vpc_id

  tags = var.common_tags

  
}

resource "aws_vpc_security_group_ingress_rule" "ingress" {

  for_each = var.allowed_ports
  security_group_id = aws_security_group.this_security_group.id

  from_port   = each.value
  to_port     = each.value
  ip_protocol = "tcp"

  cidr_ipv4 = var.ingress_source_ip

}

resource "aws_vpc_security_group_egress_rule" "all" {

  security_group_id = aws_security_group.this_security_group.id

  ip_protocol = "-1"

  cidr_ipv4 = "0.0.0.0/0"

}