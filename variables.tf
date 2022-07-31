variable "vpc-security-group-names" {
    type = list(string)
    description = "VPC Security Group (Array, Common-Name)"
}

variable "vpc-subnet-names" {
    type = list(string)
    description = "VPC Subnet(s) (Array, Common-Name)"
}

variable "api-gateway-stage-name" {
    type = string
    description = "AWS API Gateway Stage Name"
    default = "testing"
}

variable "api-gateway-name" {
    type = string
    description = "AWS API Gateway Common Name"
    default = "Example-Terraform-Advanced-API-Gateway"
}

variable "custom-cors-x-headers" {
    default = [
        "X-Allow-Banned",
        "X-No-Cache",
        "X-List-Type",
        "X-Is-Admin"
    ]
}

variable "lambda-log-group-name" {
    type = string
    description = "AWS CloudWatch Log Group for Lambda Function(s)"
    default = "Example-Terraform-Lambda-Log-Group"
}

variable "lambda-function-name" {
    type = string
    description = "AWS Lambda Function Common Name"
    default = "Example-Terraform-Lambda-Function"
}

variable "lambda-function-description" {
    type = string
    description = "AWS Lambda Function Description"
    default = "(Auto-Generated AWS Lambda Function)"
}

variable "lambda-authorizer-name" {
    type = string
    description = "AWS Lambda Function Common Name"
    default = "Example-Terraform-Authorizer"
}

variable "lambda-authorizer-description" {
    type = string
    description = "AWS Lambda Function Description"
    default = "(Auto-Generated AWS Lambda Authorizer Function)"
}

variable "lambda-artifacts-bucket" {
    type = string
    description = "AWS S3 Bucket Name"
    default = "example-terraform-advanced-api-gateway-module-bucket"
}

variable "sqs-queue-name" {
    type = string
    description = "AWS SQS Queue Common Name"
    default = "Example-Terraform-SQS-Queue"
}

variable "sns-topic-name" {
    type = string
    description = "AWS SNS Topic Common Name"
    default = "Example-Terraform-SNS-Topic"
}