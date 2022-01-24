variable "INSTANCE_COUNT" {}
variable "INSTANCE_TYPE" {}
variable "COMPONENT" {}
variable "ENV" {}
variable "APP_VERSION" {}
variable "APP_PORT" {}
variable "LB_PUBLIC" {
  default = false
}

variable "LB_PRIVATE" {
  default = false
}

variable "LB_RULE_PRIORITY" {}