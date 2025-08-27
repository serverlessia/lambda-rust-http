output "api_gateway_url" {
  description = "URL of the API Gateway endpoint"
  value       = aws_api_gateway_stage.main.invoke_url
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.main.arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.main.function_name
}
