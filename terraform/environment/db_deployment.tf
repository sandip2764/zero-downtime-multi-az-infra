resource "aws_s3_bucket" "db_artifacts" {
  bucket = "${var.project_name}-db-artifacts-2026"

  tags = {
    Name = "${var.project_name}-db-artifacts"
  }
}

resource "aws_s3_bucket_public_access_block" "db_artifacts" {
  bucket = aws_s3_bucket.db_artifacts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "db_artifacts" {
  bucket = aws_s3_bucket.db_artifacts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "db_artifacts" {
  bucket = aws_s3_bucket.db_artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}