resource "aws_ssm_parameter" "email_username" {
  name  = "/${var.base_name}/email_username"
  type  = "String"
  value = "dummy"

  lifecycle {
    ignore_changes = [value]
  }

  tags = merge({ "Name" = "${var.base_name}-email-username" }, var.common_tags)
}

resource "aws_ssm_parameter" "email_passowrd" {
  name  = "/${var.base_name}/email_passowrd"
  type  = "SecureString"
  value = "dummy"

  lifecycle {
    ignore_changes = [value]
  }

  tags = merge({ "Name" = "${var.base_name}-email-passowrd" }, var.common_tags)
}
