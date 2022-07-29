resource "aws_s3_bucket" "lambda-function-bucket" {
    bucket = var.lambda-artifacts-bucket
}

resource "aws_s3_bucket_acl" "access-control-list" {
    bucket = aws_s3_bucket.lambda-function-bucket.id
    acl    = "private"
}

resource "aws_s3_bucket_versioning" "lambda-function-versioning" {
    bucket = aws_s3_bucket.lambda-function-bucket.id

    versioning_configuration {
        status = "Enabled"
    }
}