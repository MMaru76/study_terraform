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
  name    = "iam_ec2_name"
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