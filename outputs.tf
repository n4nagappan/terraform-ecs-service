output "load_balancer_dns" {
  value = "${aws_alb.ecs-load-balancer.dns_name}"
}
