# Registration table
resource "aws_dynamodb_table" "registration" {
  name         = "${local.app_name}-registrations"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Id"

  attribute {
    name = "Id"
    type = "S"
  }

  tags = local.tags
}

# Feedback table
resource "aws_dynamodb_table" "feedback" {
  name         = "${local.app_name}-feedback"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "FeedbackId"

  attribute {
    name = "FeedbackId"
    type = "S"
  }

  tags = local.tags
}
