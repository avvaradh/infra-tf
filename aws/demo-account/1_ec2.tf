##############################
## EC2 Instance for Tunnel Server
##############################
data "aws_ami" "linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["<<amzn-specific-ami>>"]
  }

  owners = ["xxxxx"] # Canonical

}

resource "aws_instance" "looker-ssh-tunnel-server" {
  ami           = data.aws_ami.linux.id
  instance_type = "m4.2xlarge"
  
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.ingress-internal.id}",
                            "${aws_security_group.elb-tunnel.id}"]
  subnet_id              = "subnet-xxxxx"

  tags = {
    Name = "looker-elb-tunnel"
  }

  depends_on = [
    aws_security_group.ingress-internal,
    aws_security_group.elb-tunnel
  ]
}
