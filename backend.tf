terraform {
  cloud {
    organization = "paolodenti"

    workspaces {
      name = "playground"
    }
  }
}
