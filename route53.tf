resource "aws_route53_record" "private-record" {
  count   = var.LB_PRIVATE ? 1 : 0
  zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID
  name    = "${var.COMPONENT}-${var.ENV}.roboshop.internal"
  type    = "CNAME"
  ttl     = "300"
  records = [data.terraform_remote_state.alb.outputs.PRIVATE_LB_DNSNAME]
}

//resource "aws_route53_record" "public-record" {
//  count   = var.LB_PUBLIC ? 1 : 0
//  zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID
//  name    = "${var.COMPONENT}-${var.ENV}.roboshop.internal"
//  type    = "CNAME"
//  ttl     = "300"
//  records = [data.terraform_remote_state.vpc.outputs.PRIVATE_LB_DNSNAME]
//}