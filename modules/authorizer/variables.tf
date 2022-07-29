variable "name" {
    description = "Resource Endpoint Partition for Invocation of Lambda Function from API Gateway"
    type        = string
}

variable "handler" {
    description = "Lambda Function Source Export Handler"
    type        = string
    default     = "index.handler"
}

variable "description" {
    description = "Lambda Function Description"
    type        = string
}

variable "timeout" {
    description = "Runtime Timeout (Seconds) - Defaults to 30 Seconds"
    type        = number
    default     = 30
    nullable    = true
}

variable "memory-size" {
    description = "Runtime Memory Allocation (MB) - Defaults to 256"
    type        = number
    default     = 256
    nullable    = true
}

variable "vpc-configuration" {
    description = "Lambda Function VPC Connection Integration(s)"
    type        = object({
        security-group-identifiers = set(string)
        subnet-identifiers         = set(string)
    })

    default  = null
    nullable = true
}

variable "runtime" {
    description = "Runtime Language + Version"
    type        = string
    default     = null
    nullable    = true
}

variable "publish" {
    description = "Enable Lambda Version Publishing"
    type        = bool
    default     = null
    nullable    = true
}

variable "artifacts-bucket" {
    description = "AWS Lambda Function Artifacts S3 Bucket"
    type        = string
    nullable    = false
}

variable "account-id" {}
