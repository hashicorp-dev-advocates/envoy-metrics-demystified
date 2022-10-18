docs "docs" {
  port = 28080
  //open_in_browser = true

  path = "./docs"

  index_title = "Envoy"

  image {
    name = "shipyardrun/docs:v0.5.1"
  }

  index_pages = [
    "gettingstarted",
  ]
}

container "tools" {
  image {
    name = "shipyardrun/tools:v0.7.0"
  }

  network {
    name = "network.${var.consul_k8s_network}"
  }

  command = [
    "tail",
    "-f",
    "/dev/null"
  ]

  # Mount a volume containing the config
  volume {
    source      = "${shipyard()}/config/${var.consul_k8s_cluster}"
    destination = "/config"
  }

  volume {
    source      = "./files"
    destination = "/files/"
  }

  env {
    key   = "KUBECONFIG"
    value = "/config/kubeconfig-docker.yaml"
  }
}
