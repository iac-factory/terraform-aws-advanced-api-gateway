resource "aws_sns_topic_subscription" "subscription" {
    topic_arn = aws_sns_topic.topic.arn
    protocol  = "sqs"
    endpoint  = var.sqs-queue-arn
}