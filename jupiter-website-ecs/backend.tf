# store the terraform state file in s3
# terraform {
#   backend "s3" {
#     bucket         = "yourme-terraform-remote-state"
#     key            = "jupiter-website-ecs.tfstate"
#     region         = "us-east-1"
#     profile        = "default"
#     dynamodb_table = "terraform-state-lock"
#     encrypt        = true
#   }

terraform {
  cloud {
    organization = "Gihubactions"

    workspaces {
      name = "my-githubactions"
    }
  }
}