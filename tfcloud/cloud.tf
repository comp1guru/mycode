terraform {
  cloud {
    organization = "cdub"

    workspaces {
      name = "my-example"
    }
  }
}
