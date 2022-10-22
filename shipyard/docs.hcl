docs "docs" {
  port = 3000
  # open_in_browser = true

  path = "./docs"

  index_title = "Envoy"

  image {
    # see https://hub.docker.com/r/shipyardrun/docs/tags
    name = "shipyardrun/docs:v0.6.0"
  }

  index_pages = [
    "gettingstarted",
    "connections",
    "http_requests",
    "grpc_methods",
    "retries",
    "outlier_ejection",
  ]
}

container "tools" {
  image {
    # see https://hub.docker.com/r/shipyardrun/tools/tags
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
