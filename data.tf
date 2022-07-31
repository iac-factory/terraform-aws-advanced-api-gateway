module "identity" {
    source = "./modules/identity"
}

module "region" {
    source = "./modules/region"
}

module "open-api" {
    source = "./modules/open-api"

    rest-api-id = aws_api_gateway_rest_api.api.id
    rest-api-stage = aws_api_gateway_stage.stage.stage_name
}

data "aws_subnets" "subnets" {
    filter {
        name   = join(":", ["tag", "Name"])

        values = var.vpc-subnet-names
    }
}

data "aws_security_group" "sg" {
    count = length(var.vpc-security-group-names)

    name = var.vpc-security-group-names[count.index]
}