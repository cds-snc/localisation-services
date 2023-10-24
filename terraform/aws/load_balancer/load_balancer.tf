resource "aws_lb" "localisation" {
  name               = "localisation-${var.env}"
  internal           = false
  load_balancer_type = "application"

  drop_invalid_header_fields = true
  enable_deletion_protection = true

  security_groups = [
    var.security_group_lb_id
  ]
  subnets = var.subnet_public_ids

  access_logs {
    bucket  = var.cbs_satellite_bucket_name
    prefix  = "lb_logs"
    enabled = true
  }

  tags = var.common_tags
}

resource "random_string" "alb_tg_suffix" {
  length  = 3
  special = false
  upper   = false
}

resource "aws_lb_target_group" "localisation" {
  name                 = "localisation-tg-${random_string.alb_tg_suffix.result}"
  port                 = 4443
  protocol             = "HTTPS"
  target_type          = "ip"
  deregistration_delay = 30
  vpc_id               = var.vpc_id

  health_check {
    enabled  = true
    protocol = "HTTPS"
    path     = "/healthz"
    matcher  = "200-399"
  }

  stickiness {
    type = "lb_cookie"
  }

  tags = var.common_tags

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      stickiness[0].cookie_name
    ]
  }
}

resource "aws_lb_listener" "localisation" {
  load_balancer_arn = aws_lb.localisation.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.localisation.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.localisation.arn
  }

  depends_on = [
    aws_acm_certificate_validation.localisation,
    aws_route53_record.localisation_validation,
  ]

  tags = var.common_tags
}

resource "aws_lb_listener" "localisation_http_redirect" {
  load_balancer_arn = aws_lb.localisation.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = var.common_tags
}
