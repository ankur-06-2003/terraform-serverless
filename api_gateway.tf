# API Gateway HTTP API
resource "aws_apigatewayv2_api" "http_api" {
  name          = "${local.app_name}-api"
  protocol_type = "HTTP"
}

# Integration with Lambda
resource "aws_apigatewayv2_integration" "backend_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.backend.invoke_arn
  payload_format_version = "2.0"
  integration_method = "POST"

  depends_on = [
    aws_apigatewayv2_api.http_api,
    aws_lambda_function.backend
  ]
}

# Route for all requests
resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.backend_integration.id}"

  depends_on = [
    aws_apigatewayv2_integration.backend_integration
  ]
}

# Deployment stage
resource "aws_apigatewayv2_stage" "api_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"   # Use $default for simpler HTTP API usage
  auto_deploy = true

  depends_on = [
    aws_apigatewayv2_route.default_route
  ]
}

# Lambda permission to allow API Gateway to invoke
resource "aws_lambda_permission" "api_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"#-${aws_apigatewayv2_api.http_api.id}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.backend.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}

