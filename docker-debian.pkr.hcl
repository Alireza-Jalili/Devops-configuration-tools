packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}
source "docker" "debian" {
  image  = "debian:bookworm-slim"
  commit = true
}

variable "image_name" {
  default = "latest"
}

build {
  name = "packer-test"
  sources = [
    "source.docker.debian"
  ]
  post-processor "docker-tag" {
    repository = "packer-debian-image"
   tags = [var.image_name]  # Ensure this is a list
  }
}
