output "cloudfront_domain_name" {
value = aws_cloudfront_distribution.frontend.domain_name
}


output "s3_bucket" {
value = aws_s3_bucket.frontend.id
}


# output "api_invoke_url" {
# value = aws_apigatewayv2_stage.api.invoke_url
# }


output "dynamodb_registration_table" {
value = aws_dynamodb_table.registration.name
}


output "dynamodb_feedback_table" {
value = aws_dynamodb_table.feedback.name
}


output "state_machine_arn" {
value = aws_sfn_state_machine.registration.arn
}

