<!-- BEGIN_TF_DOCS -->
# test-authorizers #

*Anything with a `ⓘ` is a dropdown containing additional, contextual information.*

## Setup ##

1. Initialize the module:
```bash
terraform init
```

---

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpc-security-group-names"></a> [vpc-security-group-names](#input_vpc-security-group-names) | VPC Security Group (Array, Common-Name) | `list(string)` | n/a | yes |
| <a name="input_vpc-subnet-names"></a> [vpc-subnet-names](#input_vpc-subnet-names) | VPC Subnet(s) (Array, Common-Name) | `list(string)` | n/a | yes |
| <a name="input_api-gateway-name"></a> [api-gateway-name](#input_api-gateway-name) | AWS API Gateway Common Name | `string` | `"Example-Terraform-Advanced-API-Gateway"` | no |
| <a name="input_api-gateway-stage-name"></a> [api-gateway-stage-name](#input_api-gateway-stage-name) | AWS API Gateway Stage Name | `string` | `"testing"` | no |
| <a name="input_custom-cors-x-headers"></a> [custom-cors-x-headers](#input_custom-cors-x-headers) | List of X-* Headers for OPTIONS (CORS) Response(s) | `list(string)` | `null` | no |
| <a name="input_lambda-artifacts-bucket"></a> [lambda-artifacts-bucket](#input_lambda-artifacts-bucket) | AWS S3 Bucket Name | `string` | `"example-terraform-advanced-api-gateway-module-bucket"` | no |
| <a name="input_lambda-authorizer-description"></a> [lambda-authorizer-description](#input_lambda-authorizer-description) | AWS Lambda Function Description | `string` | `"(Auto-Generated AWS Lambda Authorizer Function)"` | no |
| <a name="input_lambda-authorizer-name"></a> [lambda-authorizer-name](#input_lambda-authorizer-name) | AWS Lambda Function Common Name | `string` | `"Example-Terraform-Authorizer"` | no |
| <a name="input_lambda-function-description"></a> [lambda-function-description](#input_lambda-function-description) | AWS Lambda Function Description | `string` | `"(Auto-Generated AWS Lambda Function)"` | no |
| <a name="input_lambda-function-name"></a> [lambda-function-name](#input_lambda-function-name) | AWS Lambda Function Common Name | `string` | `"Example-Terraform-Lambda-Function"` | no |
| <a name="input_lambda-log-group-name"></a> [lambda-log-group-name](#input_lambda-log-group-name) | AWS CloudWatch Log Group for Lambda Function(s) | `string` | `"Example-Terraform-Lambda-Log-Group"` | no |
| <a name="input_sns-topic-name"></a> [sns-topic-name](#input_sns-topic-name) | AWS SNS Topic Common Name | `string` | `"Example-Terraform-SNS-Topic"` | no |
| <a name="input_sqs-queue-name"></a> [sqs-queue-name](#input_sqs-queue-name) | AWS SQS Queue Common Name | `string` | `"Example-Terraform-SQS-Queue"` | no |
#### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_identity"></a> [identity](#module_identity) | ./modules/identity | n/a |
| <a name="module_lambda-authorizer"></a> [lambda-authorizer](#module_lambda-authorizer) | ./modules/authorizer | n/a |
| <a name="module_lambda-function"></a> [lambda-function](#module_lambda-function) | ./modules/lambda-function | n/a |
| <a name="module_open-api"></a> [open-api](#module_open-api) | ./modules/open-api | n/a |
| <a name="module_region"></a> [region](#module_region) | ./modules/region | n/a |
| <a name="module_sns"></a> [sns](#module_sns) | ./modules/sns | n/a |
| <a name="module_sqs-queue"></a> [sqs-queue](#module_sqs-queue) | ./modules/sqs | n/a |
#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cors-headers"></a> [cors-headers](#output_cors-headers) | n/a |
| <a name="output_data"></a> [data](#output_data) | n/a |
| <a name="output_schema"></a> [schema](#output_schema) | AWS API-Gateway Open-API Export + Authorization & X-API-Gateway Extension(s) |
| <a name="output_sns-publication-message"></a> [sns-publication-message](#output_sns-publication-message) | n/a |
#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement_aws) | ~>4 |
#### Resources

| Name | Type |
|------|------|
| [aws_api_gateway_account.account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_account) | resource |
| [aws_api_gateway_deployment.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_method_settings.settings](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_settings) | resource |
| [aws_api_gateway_rest_api.api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_api_gateway_stage.stage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage) | resource |
| [aws_cloudwatch_log_group.api-execution-logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.cloudwatch-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.sns-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.cloudwatch-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.sns-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.account-logging-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.api-cloudwatch-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.lambda-function-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.access-control-list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_versioning.lambda-function-versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_iam_policy.api-gateway-logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.cloudwatch-policy-document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns-policy-document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnets.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

---

## Documentation ##

<details>
<summary> ⓘ View (Drop-Down) </summary>

Documentation is both programmatically and conventionally generated.

**Note** - Given the workflow between `git` & `pre-commit`, when creating
a new commit, ensure to run the following:

```bash
git commit -a --message "..."
```

If a commit shows as a **Failure**, ***such is the job of the pre-commit hook***.
Simply re-commit and then the repository should be able to be pushed to.

### Generating `tfvars` & `tfvars.json` ###

```bash
terraform-docs tfvars hcl "$(git rev-parse --show-toplevel)"

terraform-docs tfvars json "$(git rev-parse --show-toplevel)"
```

### `terraform-docs` ###

In order to install `terraform-docs`, ensure `brew` is installed (for MacOS systems), and run

```bash
brew install terraform-docs
```

If looking to upgrade:

```bash
brew uninstall terraform-docs
brew install terraform-docs
```

It's elected to use `brew uninstall` vs `brew upgrade` because old versions are then removed.

### `git` & `pre-commit` ###

Documentation is often a second thought; refer to the following steps to ensure documentation is always updated
upon `git commit`.

1. Install Pre-Commit
```bash
brew install pre-commit || pip install pre-commit
```
2. Check Installation + Version
```bash
pre-commit --version
```
3. Generate Configuration (`.pre-commit-config.yaml`)
4. Configure `git` hooks
```bash
pre-commit install
pre-commit install-hooks
```
- If any errors show
```bash
git config --unset-all core.hooksPath
```

**Most Importantly**

> *`pre-commit install` should always be the first command after a project is cloned.*

</details>

## References ##

Regardless of involvements with the project, please acknowledge
the following philosophies:

- [**Versioning**](https://semver.org) is not an arbitrarily made up concept ([The 12-Factor Application](https://12factor.net/build-release-run)).
- For better or for worse, it's never okay to affect others without communication.
- *[Documentation](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/4/html/introduction_to_system_administration/s1-philosophy-document)* is no different than code.
<!-- END_TF_DOCS -->