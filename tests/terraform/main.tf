terraform {
  backend "http" {
  }

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

resource "local_file" "example" {
  filename = "${path.module}/example.txt"
  content  = "Hello from Terraform!\nThis file was created by the local_file resource."
}
