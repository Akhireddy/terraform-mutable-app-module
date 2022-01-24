data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "base-with-ansible"
  owners      = ["self"]
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-akhi"
    key    = "vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }

data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = "terraform-akhi"
    key    = "mutable/alb/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }

resource "aws_lb_target_group" "tg"
    name      = "${var.ENV}-${var.COMPONENT}"
    port      = 80
    protocol  = "HTTP"
    vpc_id    = data.terraform_remote_state.vpc.outputs.VPC_ID
}

resource "aws_lb_target_group_attachment" "tg-attach" {
    count             = length(aws_spot_instance_request.ec2-spot)
    target_group_arm  =  aws_lb_target_group.tg.arm
    target_id         = aws_spot_instance_request.ec2-spot.*.spot_instance_id[count.index]
    port              = 80
}


data "aws_secretsmanager_secret" "common" {
  name = "common/ssh"
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.common.id
}