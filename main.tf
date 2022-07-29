resource aws_api_gateway_rest_api "api" {
    name = var.api-gateway-name
    body = jsonencode({
        "openapi" : "3.0.1",
        "info" : {
            "title" : var.api-gateway-name
            "description" : "API Gateway Service",
            "version" : "0.0.0"
        },
        "servers" : [ ],
        "x-amazon-apigateway-endpoint-configuration": {
            "disableExecuteApiEndpoint": false
        },
        "paths" : {
            "/sns": {
                "post": {
                    "security": [{
                        (module.lambda-authorizer.function-name) : []
                    }],
                    "responses" : {
                        "200" : {
                            "description" : "200 Response",
                            "headers" : {
                                "Access-Control-Allow-Origin" : {
                                    "schema" : {
                                        "type" : "string"
                                    }
                                }
                            },
                            "content" : {
                                "application/json" : {
                                    "schema" : {
                                        "$ref" : "#/components/schemas/Default"
                                    }
                                }
                            }
                        }
                    },
                    "x-amazon-apigateway-integration" : {
                        "responses" : {
                            "default" : {
                                "statusCode" : "200",
                                "responseParameters" : {
                                    "method.response.header.Access-Control-Allow-Origin" : "'*'"
                                }
                            }
                        },
                        "credentials" : "arn:$${AWS::Partition}:iam::$${AWS::AccountId}:role/${aws_iam_role.role.name}",
                        "httpMethod" : "POST",
                        "uri": "arn:$${AWS::Partition}:apigateway:${module.region.identifier}:sns:action/Publish",
                        "requestParameters" : {
                            "integration.request.querystring.TopicArn" : "'${module.sns.arn}'",
                            "integration.request.querystring.Subject" : "method.request.body.subject",
                            "integration.request.querystring.Message" : "method.request.body.message"
                        },
                        "passthroughBehavior" : "when_no_match",
                        "type" : "aws"
                    }
                },
                "options" : {
                    "responses" : {
                        "200" : {
                            "description" : "200 Response",
                            "headers" : {
                                "Access-Control-Allow-Origin" : {
                                    "schema" : {
                                        "type" : "string"
                                    }
                                },
                                "Access-Control-Allow-Methods" : {
                                    "schema" : {
                                        "type" : "string"
                                    }
                                },
                                "Access-Control-Allow-Headers" : {
                                    "schema" : {
                                        "type" : "string"
                                    }
                                }
                            },
                            "content" : {
                                "application/json" : {
                                    "schema" : {
                                        "$ref" : "#/components/schemas/Default"
                                    }
                                }
                            }
                        }
                    },
                    "x-amazon-apigateway-integration" : {
                        "responses" : {
                            "default" : {
                                "statusCode" : "200",
                                "responseParameters" : {
                                    "method.response.header.Access-Control-Allow-Methods" : "'*'",
                                    "method.response.header.Access-Control-Allow-Headers" : "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
                                    "method.response.header.Access-Control-Allow-Origin" : "'*'"
                                }
                            }
                        },
                        "requestTemplates" : {
                            "application/json" : "{\"statusCode\": 200}"
                        },
                        "passthroughBehavior" : "when_no_match",
                        "type" : "mock"
                    }
                }
            },
            "/testing" : {
                "post" : {
                    "security": [{
                        (module.lambda-authorizer.function-name): []
                    }],
                    "responses" : {
                        "200" : {
                            "description" : "200 Response",
                            "headers" : {
                                "Access-Control-Allow-Origin" : {
                                    "schema" : {
                                        "type" : "string"
                                    }
                                }
                            },
                            "content" : {
                                "application/json" : {
                                    "schema" : {
                                        "$ref" : "#/components/schemas/Default"
                                    }
                                }
                            }
                        },
                        "500" : {
                            "description" : "500 response",
                            "headers" : {
                                "Access-Control-Allow-Origin" : {
                                    "schema" : {
                                        "type" : "string"
                                    }
                                },
                                "Access-Control-Allow-Methods" : {
                                    "schema" : {
                                        "type" : "string"
                                    }
                                },
                                "Access-Control-Allow-Headers" : {
                                    "schema" : {
                                        "type" : "string"
                                    }
                                }
                            },
                            "content" : {
                                "application/json" : {
                                    "schema" : {
                                        "$ref" : "#/components/schemas/Error"
                                    }
                                }
                            }
                        }
                    },
                    "x-amazon-apigateway-integration" : {
                        "httpMethod" : "POST",
                        "uri" : "arn:$${AWS::Partition}:apigateway:$${AWS::Region}:lambda:path/2015-03-31/functions/arn:$${AWS::Partition}:lambda:$${AWS::Region}:$${AWS::AccountId}:function:${module.lambda-function.function-name}/invocations",
                        "responses" : {
                            "default" : {
                                "statusCode" : "200"
                            }
                        },
                        "requestTemplates" : {
                            "application/json" : "{\"statusCode\":200}"
                        },
                        "passthroughBehavior" : "when_no_templates",
                        "timeoutInMillis" : 29000,
                        "contentHandling" : "CONVERT_TO_TEXT",
                        "type" : "aws_proxy",
                        "payloadFormatVersion": 1.0
                    }
                },
                "options" : {
                    "responses" : {
                        "200" : {
                            "description" : "200 Response",
                            "headers" : {
                                "Access-Control-Allow-Origin" : {
                                    "schema" : {
                                        "type" : "string"
                                    }
                                },
                                "Access-Control-Allow-Methods" : {
                                    "schema" : {
                                        "type" : "string"
                                    }
                                },
                                "Access-Control-Allow-Headers" : {
                                    "schema" : {
                                        "type" : "string"
                                    }
                                }
                            },
                            "content" : {}
                        }
                    },
                    "x-amazon-apigateway-integration" : {
                        "responses" : {
                            "default" : {
                                "statusCode" : "200",
                                "responseParameters" : {
                                    "method.response.header.Access-Control-Allow-Methods" = "'*'",
                                    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,x-allow-banned,x-no-cache,x-list-type,x-is-admin'",
                                    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
                                },
                                "responseTemplates" : {
                                    "application/json" : "{}"
                                }
                            }
                        },
                        "requestTemplates" : {
                            "application/json" : "{\"statusCode\":200}"
                        },
                        "passthroughBehavior" : "when_no_match",
                        "timeoutInMillis" : 29000,
                        "type" : "mock",
                        "payloadFormatVersion": 1.0
                    }
                }
            }
        },
        "components" : {
            "schemas" : {
                "Error" : {
                    "title" : "Error",
                    "type" : "object",
                    "description" : "Default Error Schema"
                },
                "Default" : {
                    "title" : "Default",
                    "type" : "object",
                    "description" : "Default Schema Shape"
                }
            },
            "securitySchemes" : {
                (module.lambda-authorizer.function-name): {
                    "type" : "apiKey",
                    "name" : "Authorization",
                    "in" : "header",
                    "x-amazon-apigateway-authtype" : "custom",
                    "x-amazon-apigateway-authorizer" : {
                        "authorizerUri" : "arn:$${AWS::Partition}:apigateway:$${AWS::Region}:lambda:path/2015-03-31/functions/arn:$${AWS::Partition}:lambda:$${AWS::Region}:$${AWS::AccountId}:function:${module.lambda-authorizer.function-name}/invocations",
                        "authorizerResultTtlInSeconds" : 300,
                        "type" : "token",
                        "identitySource" : "method.request.header.Authorization"
                    }
                }
            }
        }
    })
}

resource "aws_api_gateway_stage" "stage" {
    depends_on = [aws_cloudwatch_log_group.api-execution-logs, aws_iam_role.cloudwatch]

    rest_api_id          = aws_api_gateway_rest_api.api.id
    deployment_id        = aws_api_gateway_deployment.default.id
    stage_name           = var.api-gateway-stage-name
    xray_tracing_enabled = true
    description          = "The Service's Default Stage"


    access_log_settings {
        destination_arn = aws_cloudwatch_log_group.api-execution-logs.arn

        format          = jsonencode({
            requestId               = "$context.requestId"
            sourceIp                = "$context.identity.sourceIp"
            requestTime             = "$context.requestTime"
            protocol                = "$context.protocol"
            httpMethod              = "$context.httpMethod"
            resourcePath            = "$context.resourcePath"
            routeKey                = "$context.routeKey"
            status                  = "$context.status"
            responseLength          = "$context.responseLength"
            integrationErrorMessage = "$context.integrationErrorMessage"
        })
    }
}

resource "aws_api_gateway_deployment" "default" {
    rest_api_id       = aws_api_gateway_rest_api.api.id
    description       = "The Service's Currently Active Stage"
    stage_description = "Environment Specific Stage"
    triggers          = {
        redeployment = sha1(jsonencode([
            aws_api_gateway_rest_api.api
        ]))
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_api_gateway_method_settings" "settings" {
    rest_api_id = aws_api_gateway_rest_api.api.id
    stage_name  = aws_api_gateway_stage.stage.stage_name
    method_path = "*/*"

    settings {
        logging_level                              = "INFO" // "INFO"
        metrics_enabled                            = true
        data_trace_enabled                         = true
        throttling_rate_limit                      = -1
        throttling_burst_limit                     = -1
        cache_data_encrypted                       = true
        cache_ttl_in_seconds                       = 300
        caching_enabled                            = true
        require_authorization_for_cache_control    = true
        unauthorized_cache_control_header_strategy = "SUCCEED_WITH_RESPONSE_HEADER"
    }
}

module "sqs-queue" {
    source = "./modules/sqs"

    account-id = module.identity.account-id
    aws-region = module.region.identifier
    sqs-queue-name = var.sqs-queue-name
}

module "sns" {
    source = "./modules/sns"

    account-id = module.identity.account-id
    topic-name = var.sns-topic-name
    sqs-queue-arn = module.sqs-queue.sqs-queue-arn
}

module "lambda-function" {
    source = "./modules/lambda-function"

    account = module.identity.account-id

    publish = true

    name        = var.lambda-function-name
    description = var.lambda-function-description
    timeout     = 30
    memory-size = 256

    cors = {
        enable = true
        source = "arn:aws:execute-api:${module.region.current}:${module.identity.account-id}:${aws_api_gateway_rest_api.api.id}/*"
    }

    artifacts-bucket = aws_s3_bucket_versioning.lambda-function-versioning.bucket

    vpc-configuration = {
        security-group-identifiers = var.vpc-security-groups

        subnet-identifiers = var.vpc-subnets
    }

    execution-source = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

module "lambda-authorizer" {
    source = "./modules/authorizer"

    name        = var.lambda-authorizer-name
    description = var.lambda-authorizer-description

    artifacts-bucket = aws_s3_bucket_versioning.lambda-function-versioning.bucket

    vpc-configuration = {
        security-group-identifiers = var.vpc-security-groups
        subnet-identifiers = var.vpc-subnets
    }

    account-id = module.identity.account-id
}

resource "aws_cloudwatch_log_group" "api-execution-logs" {
    name              = "API-Gateway-Execution-Logs/${aws_api_gateway_rest_api.api.id}/${var.api-gateway-stage-name}"
    retention_in_days = 7
}