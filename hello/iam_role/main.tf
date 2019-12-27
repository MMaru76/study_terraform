# variable "name" {}
# variable "policy" {}
variable "identifier" {}

resource "aws_iam_role" "tabiya01" {
  name               = "tabiya-role"
  assume_role_policy = data.aws_iam_policy_document.tabiya_assume.json
}

data "aws_iam_policy_document" "tabiya_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = [var.identifier]
    }
  }
}

resource "aws_iam_policy" "tabiya02" {
  name   = "tabiya-policy"
  policy = data.aws_iam_policy_document.allow_describe_regions.json
}

data "aws_iam_policy_document" "allow_describe_regions" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:DescribeRegions"] # リージョン一覧を取得する
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "tabiya03" {
  role       = aws_iam_role.tabiya01.name
  policy_arn = aws_iam_policy.tabiya02.arn
}

output "iam_role_arn" {
  value = aws_iam_role.tabiya01.arn
}

output "iam_role_name" {
  value = aws_iam_role.tabiya01.name
}
