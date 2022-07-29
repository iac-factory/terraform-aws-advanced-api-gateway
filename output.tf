output "schema" {
    description = "AWS API-Gateway Open-API Export + Authorization & X-API-Gateway Extension(s)"

    value = module.open-api.schema
}

/*** {"message":{"information":{"name":"name","parameters":{"identifier":"-1"},"type":"JSON"}},"subject":"subject-name"} */

output "sns-publication-message" {
    value = jsonencode({
        "subject" : "subject-name"
        "message" : {
            "information" : {
                "name" : "name",
                "type" : "JSON",
                "parameters" : {
                    "identifier" : "-1"
                }
            }
        }
    })
}