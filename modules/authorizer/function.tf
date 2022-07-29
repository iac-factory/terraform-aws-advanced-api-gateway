data "external" "installation" {
    program = [
        "node",
        join("/", [
            path.module,
            "terraform.js"
        ])
    ]
}

data "archive_file" "lambda-function-layer" {
    type        = "zip"
    source_dir  = join("/", [
        path.module,
        "layer"
    ])
    output_path = join("/", [
        path.module,
        "layer-artifact",
        join(".", [
            "Authorizer-Lambda-Dependencies",
            "zip"
        ])
    ])

    depends_on = [
        data.external.installation
    ]
}

# Archive - Although the following namespace belongs to a `data` type,
# such will still create a new "resource", where the resource is a zip
# file of the source path(s).
data "archive_file" "lambda-function-artifacts" {
    type        = "zip"
    source_dir  = join("/", [
        path.module,
        "src"
    ])
    output_path = join("/", [
        path.module,
        "distribution",
        join(".", [
            lower(replace(var.name, " ", "-")),
            "zip"
        ])
    ])
}

resource "aws_s3_object" "layer-artifacts" {
    bucket = var.artifacts-bucket
    key    = "Authorizer-Lambda-Dependencies.zip"
    source = data.archive_file.lambda-function-layer.output_path
}

resource "aws_lambda_layer_version" "layer" {
    layer_name = "Authorizer-Lambda-Dependencies"

    s3_bucket         = aws_s3_object.layer-artifacts.bucket
    s3_key            = aws_s3_object.layer-artifacts.key
    s3_object_version = aws_s3_object.layer-artifacts.version_id

    // filename = data.archive_file.lambda-function-layer.output_path

    compatible_runtimes = [
        "nodejs16.x"
    ]
}

resource "aws_lambda_function" "function" {
    function_name = var.name
    /// substr(var.name, 0, 139)
    filename      = data.archive_file.lambda-function-artifacts.output_path
    description   = var.description
    memory_size   = var.memory-size
    package_type  = "Zip"
    runtime       = (var.runtime != null) ? var.runtime : "nodejs16.x"
    publish       = (var.publish != null) ? var.publish : true
    role          = aws_iam_role.role.arn
    handler       = var.handler
    timeout       = (var.timeout != null) ? var.timeout : 30

    layers = [
        aws_lambda_layer_version.layer.arn
    ]

    vpc_config {
        security_group_ids = (var.vpc-configuration != null) ? try(var.vpc-configuration.security-group-identifiers, [ ]) : [ ]
        subnet_ids         = (var.vpc-configuration != null) ? try(var.vpc-configuration.subnet-identifiers, [ ]) : [ ]
    }

    tracing_config {
        mode = "Active"
    }

    environment {
        variables = jsondecode(file(join("/", [
            path.module,
            "env.json"
        ])))
    }

    depends_on = [
        data.archive_file.lambda-function-artifacts,
        data.archive_file.lambda-function-layer
    ]
}