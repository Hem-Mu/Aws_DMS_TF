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
        path = "C:/Users/김햄무/Desktop/terraform/Aws/@init_network/terraform.tfstate"
    }   
}