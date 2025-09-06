
# Package the backend folder into a zip file
data "archive_file" "backend_zip" {
  type        = "zip"
  source_dir  = "../collage-fest/Backend"
  output_path = "${path.module}/backend.zip"

  excludes = [".env"] # exclude local environment file
}
# Lambda function
resource "aws_lambda_function" "backend" {
  function_name = "${var.app_name}-backend"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "index.handler"          # entrypoint in index.js
  runtime       = "nodejs22.x"
  filename      = data.archive_file.backend_zip.output_path
  source_code_hash = data.archive_file.backend_zip.output_base64sha256

  environment {
    variables = {
      NODE_ENV = "production"
      # put DB creds, API keys here instead of .env
      REGISTRATION_TABLE = aws_dynamodb_table.registration.name
      FEEDBACK_TABLE     = aws_dynamodb_table.feedback.name
      # AWS_REGION         = var.aws_region
    }
  }
}



