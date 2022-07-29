output "invoke-arn" {
    value = aws_lambda_function.function.invoke_arn
}

output "function-name" {
    value = aws_lambda_function.function.function_name
}