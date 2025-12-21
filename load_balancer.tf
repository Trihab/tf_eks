## Deploy LB
resource "aws_lb" "app_lb" {
  name               = "app-lb-tf"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.core-compute.pub_subnets_ids
  security_groups    = [aws_security_group.allow_http_lb.id]
  enable_deletion_protection = false

  #   access_logs {
  #     bucket  = aws_s3_bucket.lb_logs.id
  #     prefix  = "test-lb"
  #     enabled = true
  #   }

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eks_nodes.arn
  }
}

resource "aws_lb_target_group" "eks_nodes" {
  name     = "eks-nodes-tg"
  port     = 30080
  protocol = "HTTP"
  vpc_id   = module.core-compute.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}