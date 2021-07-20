output "lambda_function_arn" {
  description = "ARN of Lambda function"
  value       = aws_lambda_function.apply_security_headers.arn
}

output "lambda_qualified_arn" {
  description = "Qualified ARN of Lambda function"
  value       = aws_lambda_function.apply_security_headers.qualified_arn
}
