resource "aws_security_group" "sg" {
  name        = "sg_${var.COMPONENT}_${var.ENV}"
  description = "sg_${var.COMPONENT}_${var.ENV}"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description      = "APP"
    from_port        = var.APP_PORT
    to_port          = var.APP_PORT
    protocol         = "tcp"
    cidr_blocks      = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBENT_CIDR

  }
 ingress {
  description      = "SSH"
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = contact(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBENT_CIDR,tolist([data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]))

}

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
tags = {
  Name = "sg_${var.COMPONENT}_${var.ENV}"
}
}