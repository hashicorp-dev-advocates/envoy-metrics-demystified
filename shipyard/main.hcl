variable "consul_health_check_timeout" {
  default     = "240s"
  description = "Increase the timeout for when running on CI, Consul startup can take longer due to limited resources"
}

# Mandatory variables
variable "consul_k8s_cluster" {
  default = "dc1"
}

variable "consul_k8s_network" {
  default = "dc1"
}
# Mandatory variables

variable "consul_smi_controller_enabled" {
  description = "Should the SMI controller be installed"
  default     = false
}

variable "consul_release_controller_enabled" {
  description = "Enable the Consul Release Controller?"
  default     = false
}

variable "consul_acls_enabled" {
  description = "Enable ACLs for securing the Consul server"
  default     = true
}

variable "consul_tls_enabled" {
  description = "Enable TLS to secure the Consul server"
  default     = true
}

variable "consul_ingress_gateway_enabled" {
  description = "Should Ingress Gateways be enabled?"
  default     = true
}

variable "consul_transparent_proxy_enabled" {
  description = "Enable the Transparent Proxy feature for the entire cluster for Consul Service Mesh"
  default     = true
}

variable "consul_auto_inject_enabled" {
  description = "Enable the automatic injection of sidecar proxies for Kubernetes Pods"
  default     = true
}

variable "monitoring_loki_enabled" {
  default     = false
}

variable "monitoring_tempo_enabled" {
  default     = false
}

variable "consul_auto_inject_deny_namespaces" {
  description = "List of Kubernetes Namespaces where auto inject is ignored"

  default = [
    "monitoring"
  ]
}

variable "consul_monitoring_enabled" {
  description = "Should the monitoring stack (Prometheus, Grafana, Loki, and Tempo) be installed?"
  default     = true
}

# End optional variables

k8s_cluster "dc1" {
  driver = "k3s"

  nodes = 1

  network {
    name = "network.dc1"
  }
}

output "KUBECONFIG" {
  value = k8s_config("dc1")
}

network "dc1" {
  subnet = "10.5.0.0/16"
}

module "consul" {
  # see https://github.com/shipyard-run/blueprints/tree/00bb8047e7d0443f182e66c76706192be0ca1cb5/modules/kubernetes-consul
  source = "github.com/shipyard-run/blueprints?ref=e565069b64e17a430f2d4cf31f6842b12006d0d7/modules//kubernetes-consul"
}

k8s_config "app" {
  depends_on = ["module.consul"]

  cluster = "k8s_cluster.dc1"

  paths = [
    "./app/consul-config.yaml",
    "./app/api.yaml",
    "./app/payments_v1.yaml",
    "./app/payments_v2.yaml",
    "./app/currency_v1.yaml",
    "./app/currency_v2.yaml",
    "./app/loadtest.yaml",
    "./app/metrics.yaml",
    "./app/application-dashboard.yaml",
  ]

  wait_until_ready = true
}
#
#ingress "public" {
#  source {
#    driver = "local"
#
#    config {
#      port = 19090
#    }
#  }
#
#  destination {
#    driver = "k8s"
#
#    config {
#      cluster = "k8s_cluster.dc1"
#      address = "api.default.svc"
#      port    = 9090
#    }
#  }
#}
