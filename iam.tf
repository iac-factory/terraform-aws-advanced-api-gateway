/*** Trust Policy Documents */

data "aws_iam_policy_document" "cloudwatch-policy-document" {
    statement {
        effect    = "Allow"
        resources = [ "*" ]
        actions   = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams",
            "logs:PutLogEvents",
            "logs:GetLogEvents",
            "logs:FilterLogEvents"
        ]
    }
}

data "aws_iam_policy_document" "sns-policy-document" {
    statement {
        effect  = "Allow"
        actions = [
            "sns:Publish",
            "sqs:SendMessage"
        ]
        resources = [
            "arn:${module.identity.partition}:sns:${module.region.identifier}:${module.identity.account-id}:*",
            "arn:${module.identity.partition}:sqs:${module.region.identifier}:${module.identity.account-id}:*"
        ]
    }
}

/*** Customer Managed Policies */

resource "aws_iam_policy" "sns-policy" {
    name   = format("%s-SNS-Policy", "Example-Terraform-IAM")
    description = "(Auto-Generated IAM Policy)"
    policy = data.aws_iam_policy_document.sns-policy-document.json
}

resource "aws_iam_policy" "cloudwatch-policy" {
    name        = format("%s-CW-Policy", "Example-Terraform-IAM")
    description = "(Auto-Generated IAM Policy)"
    policy      = data.aws_iam_policy_document.cloudwatch-policy-document.json
}

/*** AWS Managed Policies */

 data "aws_iam_policy" "api-gateway-logging" {
     name = "AmazonAPIGatewayPushToCloudWatchLogs"
 }

/*** IAM Role */

resource "aws_iam_role" "role" {
    name                  = format("%s-IAM-Role", "Example-Terraform-SNS-API-Publication")
    force_detach_policies = false
    description           = "..."

    inline_policy {
        name = format("%s-SNS-Inline-Policy", "Example-Terraform-IAM")
        policy = jsonencode({
            Version = "2012-10-17"
            Statement = [
                {
                    Action   = ["sns:Publish*"]
                    Effect   = "Allow"
                    Resource = "*"
                },
            ]
        })
    }

    assume_role_policy = jsonencode({
        Version   = "2012-10-17"
        Statement = [
            {
                Action    = "sts:AssumeRole"
                Effect    = "Allow"
                Sid       = ""
                Principal = {
                    Service = "sns.amazonaws.com"
                }
            },
            {
                Action    = "sts:AssumeRole"
                Effect    = "Allow"
                Sid       = ""
                Principal = {
                    Service = "apigateway.amazonaws.com"
                }
            }
        ]
    })
}

resource "aws_iam_role" "cloudwatch" {
    name = "API-Gateway-CW-Account-Role"

    assume_role_policy = jsonencode({
        Version   = "2012-10-17"
        Statement = [
            {
                Action    = "sts:AssumeRole"
                Effect    = "Allow"
                Sid       = ""
                Principal = {
                    Service = "apigateway.amazonaws.com"
                }
            }
        ]
    })
}

/*** API-Gateway IAM + Logging Enablement */

resource "aws_api_gateway_account" "account" {
    cloudwatch_role_arn = aws_iam_role.cloudwatch.arn
}

/*** IAM Role + Genearl Policy Attachments */

resource "aws_iam_policy_attachment" "sns-attachment" {
    name       = format("%s-IAM-Policy-Attachment", "Example-Terraform-SNS-API-Publication")
    policy_arn = aws_iam_policy.sns-policy.arn
    roles = [
        aws_iam_role.role.name
    ]
}

resource "aws_iam_policy_attachment" "cloudwatch-attachment" {
    name       = format("%s-IAM-Policy-Attachment", "Example-Terraform-CW")
    policy_arn = aws_iam_policy.cloudwatch-policy.arn
    roles = [
        aws_iam_role.role.name
    ]
}

resource "aws_iam_role_policy_attachment" "api-cloudwatch-attachment" {
    policy_arn = aws_iam_policy.cloudwatch-policy.arn
    role = aws_iam_role.role.name
}

resource "aws_iam_role_policy" "account-logging-policy" {
    role = aws_iam_role.cloudwatch.id

    policy = data.aws_iam_policy_document.cloudwatch-policy-document.json
}