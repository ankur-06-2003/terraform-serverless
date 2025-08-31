resource "aws_sfn_state_machine" "registration" {
  name     = "${local.app_name}-workflow"
  role_arn = aws_iam_role.sfn_role.arn

  definition = jsonencode({
    StartAt = "ProcessRegistration",
    States = {
      ProcessRegistration = {
        Type     = "Task",
        Resource = aws_lambda_function.backend.arn,
        End      = true
      }
    }
  })
}
