variable "name" {}       # 名前
variable "policy" {}     # ポリシー
variable "identifier" {} # 識別子

provider "aws" {
    region = "ap-northeast-1"
}

resource "aws_iam_role" "iam_role_resource" {
  name                = "iam_ec2_role_name"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_data.json
}

data "aws_iam_policy_document" "ec2_assume_role_data" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [var.identifier]
    }
  }
}

resource "aws_iam_policy" "iam_policy_resource" {
  name    = var.name
  policy  = var.policy
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachments_resource" {
  role        = aws_iam_role.iam_role_resource.name
  policy_arn  = aws_iam_policy.iam_policy_resource.arn
}

output "iam_role_arn" {
  value = aws_iam_role.iam_role_resource.arn
}

output "iam_role_name" {
  value = aws_iam_role.iam_role_resource.name
}

