terraform {
  cloud {
    organization = "pc-terraform"

    workspaces {
      name = "pc-terraform-dev"
    }
  }
}