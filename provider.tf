terraform {
    required_providers {
        aws = "~>4"
    }
}

provider "aws" {
    shared_config_files      = [ "~/.aws/config" ]
    shared_credentials_files = [ "~/.aws/credentials" ]
    profile                  = "default"

    skip_metadata_api_check = false
}