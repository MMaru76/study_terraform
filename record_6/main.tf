# resource "aws_s3_bucket" "private_tabiya01" {
#   bucket = "tabiya-private-pragmatic-terraform"

#   versioning {
#     enabled = true
#   }

#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
#   }

#   lifecycle_rule {
#     enabled = true

#     expiration {
#       days = "1"
#     }
#   }
# }


resource "aws_s3_bucket_policy" "alb_tabiya02_policy" {
  bucket = aws_s3_bucket.alb_tabiya02_bucket.id
  policy = data.aws_iam_policy_document.alb_tabiya02_docment.json
}

data "aws_iam_policy_document" "alb_tabiya02_docment" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_tabiya02_bucket.id}/*"]

    principals {
      type        = "AWS"
      identifiers = ["YOU ACCOUNT ID"]
    }
  }
}

resource "aws_s3_bucket" "alb_tabiya02_bucket" {
  bucket = "alb-tabiya02-pragmatic-terraform"
  acl    = "public-read"
  force_destroy = true

  cors_rule {
    allowed_origins = ["https://example.com"]
    allowed_methods = ["GET"]
    allowed_headers = ["*"]
    max_age_seconds = 3000
  }
}


# resource "aws_s3_bucket_public_access_block" "private011" {
#   bucket                  = aws_s3_bucket.private_tabiya01.id
#   block_public_acls       = false
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_public_access_block" "public021" {
#   bucket                  = aws_s3_bucket.public_tabiya02.id
#   block_public_acls       = false
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }



# 外部定義 リージョン指定
/////////////////////////////////////////////////////////
provider "aws" {
  region = "ap-northeast-1"
}
/////////////////////////////////////////////////////////