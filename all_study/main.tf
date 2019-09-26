provider "aws" {
    region = "ap-northeast-1"
}

data "aws_iam_policy_document" "allow_describe_regions" {
  statement {
    effect      = "Allow"
    actions     = ["ec2:DescribeRegions"]
    resources   = ["*"]
  }
}

resource "aws_iam_policy" "exa" {
  name    = "iam_oreo"
  policy  = data.aws_iam_policy_document.allow_describe_regions.json
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}