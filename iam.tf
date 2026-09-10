data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_iam_role" "ec2" {
  name = "${var.base_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = merge({ "Name" = "${var.base_name}-ec2-role" }, var.common_tags)
}

resource "aws_iam_policy" "ec2" {
  name        = "${var.base_name}-ec2-policy"
  description = "Minimal placeholder permissions for ${var.base_name} EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowDescribeInstances"
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances"
        ]
        Resource = "*"
      },
      {
        Sid    = "AllowReadEmailParameters"
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters"
        ]
        Resource = [
          aws_ssm_parameter.email_username.arn,
          aws_ssm_parameter.email_passowrd.arn
        ]
      },
      {
        Sid    = "AllowDecryptSsmSecureStrings"
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "kms:CallerAccount" = data.aws_caller_identity.current.account_id
            "kms:ViaService"    = "ssm.${data.aws_region.current.region}.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = merge({ "Name" = "${var.base_name}-ec2-policy" }, var.common_tags)
}

resource "aws_iam_role_policy_attachment" "ec2" {
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.ec2.arn
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.base_name}-ec2-instance-profile"
  role = aws_iam_role.ec2.name

  tags = merge({ "Name" = "${var.base_name}-ec2-instance-profile" }, var.common_tags)
}
