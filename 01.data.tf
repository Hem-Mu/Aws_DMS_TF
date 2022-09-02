# terraform {
#   backend "s3" {
#     bucket         = "hemmu" # bucket name
#     key            = "terraform/terraform.tfstate"
#     region         = "ap-northeast-2"
#     dynamodb_table = "terraform-up-and-running-locks" # dynamoDB table name
#     encrypt        = true
#   }
# } # depends on S3

data "terraform_remote_state" "network" {
    backend = "local"
    config = {
        path = ".././terraform.tfstate"
    }   
}
data "terraform_remote_state" "docdb" {
    backend = "local"
    config = {
        path = "../@docDB/terraform.tfstate"
    }   
}
