resource "aws_s3_bucket" "uli-ac-test-assignment" {
  bucket = "uli-ac-test-assignment"
}

resource "aws_s3_bucket_acl" "uli-ac-test-assignment" {
  bucket = aws_s3_bucket.uli-ac-test-assignment.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "test-versioning" {
  bucket = aws_s3_bucket.uli-ac-test-assignment.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "test-db" {
    name           = "test-db"
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        "Name" = "Test dynamodb"
    }
}