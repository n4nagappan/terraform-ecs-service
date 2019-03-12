resource "aws_ecs_cluster" "terraform-ecs-cluster" {
  name = "${var.ecs_cluster}"
}
