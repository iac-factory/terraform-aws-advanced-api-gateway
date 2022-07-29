data "aws_iam_policy_document" "policy" {
    policy_id = "${var.topic-name}-Policy"

    statement {
        actions = [
            "SNS:GetTopicAttributes",
            "SNS:SetTopicAttributes",
            "SNS:AddPermission",
            "SNS:RemovePermission",
            "SNS:DeleteTopic",
            "SNS:Subscribe",
            "SNS:ListSubscriptionsByTopic",
            "SNS:Publish",
            "SNS:Receive"
        ]

        condition {
            test     = "StringEquals"
            variable = "AWS:SourceOwner"

            values = [
                var.account-id,
            ]
        }

        effect = "Allow"

        principals {
            type        = "AWS"
            identifiers = ["*"]
        }

        resources = [
            aws_sns_topic.topic.arn,
        ]
    }
}