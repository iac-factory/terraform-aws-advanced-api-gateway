resource "aws_sns_topic" "topic" {
    name = var.topic-name

    delivery_policy = file(join("/", [path.module, "delivery.json"]))

    kms_master_key_id = "alias/aws/sns"

    content_based_deduplication = false
    fifo_topic = false
}