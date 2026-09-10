resource "aws_ssm_parameter" "email_username" {
  name  = "/${var.base_name}/email_username"
  type  = "String"
  value = "dummy"

  lifecycle {
    ignore_changes = [value]
  }

  tags = merge({ "Name" = "${var.base_name}-email-username" }, var.common_tags)
}

resource "aws_ssm_parameter" "email_password" {
  name  = "/${var.base_name}/email_password"
  type  = "SecureString"
  value = "dummy"

  lifecycle {
    ignore_changes = [value]
  }

  tags = merge({ "Name" = "${var.base_name}-email-password" }, var.common_tags)
}
