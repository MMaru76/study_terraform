provider "aws" {
    region = "ap-northeast-1"
}

data "aws_iam_policy_document" "allow_describe_regions_data" {
  statement {
    effect      = "Allow"
    actions     = ["ec2:DescribeRegions"]
    resources   = ["*"]
  }
}

resource "aws_iam_policy" "iam_policy_resource" {
  name    = "iam_ec2_policy_name"
  policy  = data.aws_iam_policy_document.allow_describe_regions_data.json
}

data "aws_iam_policy_document" "ec2_assume_role_data" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_role_resource" {
  name                = "iam_ec2_role_name"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_data.json
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachments_resource" {
  role        = aws_iam_role.iam_role_resource.name
  policy_arn  = aws_iam_policy.iam_policy_resource.arn
}