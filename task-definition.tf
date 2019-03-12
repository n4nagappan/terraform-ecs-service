data "aws_ecs_task_definition" "nginx" {
  task_definition = "${aws_ecs_task_definition.nginx.family}"
	depends_on = [ "aws_ecs_task_definition.nginx" ]
}

resource "aws_ecs_task_definition" "nginx" {
    family                = "hello_world"
    container_definitions = <<DEFINITION
[
  {
    "name": "nginx",
    "image": "nginx:latest",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "memory": 500,
    "cpu": 10
  }
]
DEFINITION
}
