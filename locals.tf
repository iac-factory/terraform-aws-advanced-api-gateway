locals {
    iam-arn-prefix = "arn:$${AWS::Partition}:iam::$${AWS::AccountId}"
    lambda-function-uri = "arn:$${AWS::Partition}:apigateway:$${AWS::Region}:lambda:path/2015-03-31/functions/arn:$${AWS::Partition}:lambda:$${AWS::Region}:$${AWS::AccountId}:function"

    default-cors-headers  = [
        "Content-Type",
        "X-Amz-Date",
        "Authorization",
        "X-Api-Key",
        "X-Amz-Security-Token",
        "Access-Control-Allow-Origin",
        "Access-Control-Allow-Methods",
        "Access-Control-Allow-Headers"
    ]

    cors-headers-string = join(",", [ for header in concat(var.custom-cors-x-headers, local.default-cors-headers) : title(header) ])

    cors-headers = "'${local.cors-headers-string}'"

    options-mock = jsonencode({
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
                        "method.response.header.Access-Control-Allow-Headers" : local.cors-headers,
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
    })

    open-api = {
        schemas = jsonencode({
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
            }
        })
    }
}