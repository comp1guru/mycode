/* main.tf
   Alta3 Research - rzfeeser@alta3.com
   CHALLENGE 01 - terraform configuration file to deploy an nginx container */

# terraform block
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }
}

# provider block
provider "docker" {}

# resource block - ensures an image will become present
resource "docker_image" "simplegoservice" {
  name         = "registry.gitlab.com/alta3/simplegoservice"
  keep_locally = true    // keep image after "destroy"
}

# resource block - ensures a container will become present
resource "docker_container" "simplegoservice" {
  # reference to the "docker_image.simplegoservice" resource
  # the "image_id" references the image created in the other resource block
  image = docker_image.simplegoservice.image_id
  name  = var.container_name
  # container ports
  # - internal is the port the container is listening on
  # - external is the port the local system is listening on
  ports {
    internal = var.internal_port
    external = var.external_port
  }
}
