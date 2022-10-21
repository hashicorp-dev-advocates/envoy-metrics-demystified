packer {
  # see https://developer.hashicorp.com/packer/docs/templates/hcl_templates/blocks/packer#specifying-plugin-requirements
  required_plugins {
    # see https://developer.hashicorp.com/packer/plugins/builders/googlecompute
    # and https://github.com/hashicorp/packer-plugin-googlecompute/releases
    googlecompute = {
      version = ">= 1.0.16"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

# see https://developer.hashicorp.com/packer/plugins/builders/googlecompute
source "googlecompute" "image" {
  # the following configuration represents a minimal variable selection
  # for all options see: https://developer.hashicorp.com/packer/plugins/builders/googlecompute#configuration-reference
  machine_type        = "n1-standard-4"
  project_id          = var.project_id
  ssh_username        = "ubuntu"
  image_name          = "shipyard"
  source_image        = "ubuntu-2204-jammy-v20221018"
  source_image_family = "ubuntu-2204-lts"

  source_image_project_id = [
    "ubuntu-os-cloud"
  ]

  zone = "us-west1-b"
}

# see https://developer.hashicorp.com/packer/docs/builders/file
source "file" "image_information" {
  content = "Image built at ${formatdate("YYYY-MM-DD @ hh:mm ZZZ", timestamp())}."
  target  = "/tmp/image.txt"
}

build {
  sources = [
    "sources.googlecompute.image"
  ]

  # see https://developer.hashicorp.com/packer/docs/provisioners/shell
  provisioner "shell" {
    script = "./scripts/instance-setup.sh"
  }

  # see https://developer.hashicorp.com/packer/docs/provisioners/shell
  provisioner "shell-local" {
    script = "./scripts/make-image-public.sh"
  }
}

