resource "aws_sns_topic_policy" "default" {
    arn = aws_sns_topic.topic.arn

    policy = data.aws_iam_policy_document.policy.json
}