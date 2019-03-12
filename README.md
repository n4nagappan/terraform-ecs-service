# terraform-ecs-service
Terraform scripts to create everything needed for a working ECS cluster on AWS cloud. The cluster runs the `nginx` service for demo.

## Setup SSH keys
You'll need to create ssh keys for logging into ECS instances
```
mkdir ssh-keys
cd ssh-keys
ssh-keygen -t rsa -f terraform -q -N ""
```

## Initialization
```
terraform init
```

## Create ECS cluster
```
terraform apply
```

The Load balancer DNS is one of the outputs
```
load_balancer_dns = terraform-ecs-load-balancer-313789802.us-west-1.elb.amazonaws.com
```

Head over to `terraform-ecs-load-balancer-313789802.us-west-1.elb.amazonaws.com` to see the nginx service running

## To tear down the infra
```
terraform destroy
```
