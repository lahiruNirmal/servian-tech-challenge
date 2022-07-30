terraform {
  backend "http" {
  }
}


# # Uncomment this block if you are using shell script to deploy the infrastructure
# terraform {
#   backend "local" {
#     path = "./.terraform_backend/terraform.tfstate"
#   }
# }