variable "rest-api-id" {
    description = "API Gateway Rest API Identifier"
}

variable "rest-api-stage" {
    description = "API Gateway Rest Stage Name"
}

data "aws_api_gateway_export" "gateway" {
    rest_api_id = var.rest-api-id
    stage_name  = var.rest-api-stage
    export_type = "oas30"
    accepts = "application/json"
    parameters = {
        extensions = "apigateway"
    }
}

data "aws_api_gateway_export" "authorizers" {
    rest_api_id = var.rest-api-id
    stage_name  = var.rest-api-stage
    export_type = "oas30"
    accepts = "application/json"
    parameters = {
        extensions = "authorizers"
    }
}

output "schema" {
    value = merge(jsondecode(data.aws_api_gateway_export.gateway.body), jsondecode(data.aws_api_gateway_export.authorizers.body))
}