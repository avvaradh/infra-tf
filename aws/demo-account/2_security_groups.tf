##################################
# Internal SSH
##################################

resource "aws_security_group" "ingress-internal" {
name = "allow-internal-sg"
vpc_id = "vpc-xxxxxxxxx"  # Need to import the VPC for not hard coding here
ingress {
    cidr_blocks = [
      "x.x.x.x/x"
    ]
from_port = xx
    to_port = xx
    protocol = "tcp"
  }
// Terraform removes the default rule
  egress {
   from_port = x
   to_port = x
   protocol = "xxx"
   cidr_blocks = ["x.x.x.x/x"]
 }

  tags = {
    Name = "looker-elb-tunnel"
  }
}


##################################
# Looker to Public ELB
##################################

resource "aws_security_group" "looker-elb" {
name = "allow-looker-elb"
vpc_id = "vpc-xxxxx"  # Need to import the VPC for not hard coding here
ingress {
    cidr_blocks = "${var.looker_cidrs_us_east_1}"
from_port = xxxxx
    to_port = xxxxx
    protocol = "tcp"
  }
// Terraform removes the default rule
  egress {
   from_port = x
   to_port = x
   protocol = "xxx"
   cidr_blocks = ["${aws_instance.looker-ssh-tunnel-server.private_ip}/32"]
 }

  tags = {
    Name = "looker-elb-tunnel"
  }
}


##################################
# Public ELB and Instance Lockdown
##################################

resource "aws_security_group" "elb-tunnel" {
name = "allow-elb-tunnel"
vpc_id = "vpc-xxxxx"  # Need to import the VPC for not hard coding here
ingress {
    cidr_blocks = [
      "x.x.x.x/x"  
    ]  # ELB private Ips
    from_port = xxx
    to_port = xxx
    protocol = "tcp"
  }
// Terraform removes the default rule
  egress {
   from_port = x
   to_port = x
   protocol = "xxx"
   cidr_blocks = ["x.x.x.x/32"]  # Ip range of sql server.
 }

  tags = {
    Name = "looker-elb-tunnel"
  }
}