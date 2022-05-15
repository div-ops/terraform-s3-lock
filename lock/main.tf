provider "aws" {
  region = var.aws_region
}

# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = var.s3_bucket_name

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = var.s3_lifecycle_prevent_destroy
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = var.dynamodb_table_name
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

variable "s3_lifecycle_prevent_destroy" {
  description = "s3 lifecycle prevent_destroy"
  type        = bool
  default     = true
}

variable "s3_bucket_name" {
  description = "s3 bucket name"
  type        = string
}

variable "dynamodb_table_name" {
  description = "dynamodb table name"
  type        = string
}

variable "aws_region" {
  description = "aws region"
  type        = string
}
