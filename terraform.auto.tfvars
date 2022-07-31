vpc-security-group-names = ["sg_lambda-rds"]
vpc-subnet-names = [ "frontend-private-*" ]
custom-cors-x-headers = [
    "X-Allow-Banned",
    "X-No-Cache",
    "X-List-Type",
    "X-Is-Admin"
]
