output "sqs-queue-name" {
    value = aws_sqs_queue.queue.name
}

output "sqs-queue-arn" {
    value = aws_sqs_queue.queue.arn
}