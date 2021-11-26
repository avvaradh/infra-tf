##############################
## Classic Load Balancer to forward request from port xxxx to xx
##############################

resource "aws_elb" "looker-elb-tunnel" {
  name               = "load-balancer"

#  access_logs {
#    bucket        = "foo"
#    bucket_prefix = "bar"
#    interval      = 60
#  }

  listener {
    instance_port     = xx
    instance_protocol = "tcp"
    lb_port           = xxxx
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 5
    target              = "TCP:xx"
    interval            = 30
  }

  instances                   = [aws_instance.looker-ssh-tunnel-server.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 300
  connection_draining         = true
  connection_draining_timeout = 300

  subnets = [
    "subnet-xxxxxxx",
    "subnet-xxxxxxx"
  ]

  security_groups = [
     "${aws_security_group.looker-elb.id}"
  ]

  tags = {
    Name = "looker-elb-tunnel"
  }

  depends_on = [
    aws_instance.looker-ssh-tunnel-server
  ]
}
