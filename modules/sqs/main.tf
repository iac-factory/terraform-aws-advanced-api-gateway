resource "aws_sqs_queue" "queue" {
    name = var.sqs-queue-name

    policy = data.aws_iam_policy_document.sqs-queue-policy.json
}

data "aws_iam_policy_document" "sqs-queue-policy" {
    policy_id = "arn:aws:sqs:${var.aws-region}:${var.account-id}:${var.sqs-queue-name}/Default-Policy"

    statement {
        effect = "Allow"

        principals {
            type        = "AWS"
            identifiers = ["*"]
        }

        actions = [
            "SQS:SendMessage",
        ]

        resources = [
            "arn:aws:sqs:${var.aws-region}:${var.account-id}:${var.sqs-queue-name}",
        ]

        condition {
            test     = "ArnEquals"
            variable = "aws:SourceArn"

            values = [
                "arn:aws:sns:${var.aws-region}:${var.account-id}:*",
            ]
        }
    }
}