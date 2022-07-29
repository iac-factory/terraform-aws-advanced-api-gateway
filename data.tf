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