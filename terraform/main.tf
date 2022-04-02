terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "k8s" {

  name   = var.cluster_name
  region = "nyc1"
  version = "1.21.10-do.0"

  node_pool {
    name       = "default"
    size       = "s-4vcpu-8gb"
    node_count = 3
  }
}

resource "digitalocean_kubernetes_node_pool" "node_critical" {

  cluster_id = digitalocean_kubernetes_cluster.k8s.id

  name       = "critical-pool"
  size       = "s-2vcpu-4gb"
  node_count = 2
  tags       = ["critical"]
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}
variable "cluster_name" {}

output "kubernetes_endpoint" {
    value = digitalocean_kubernetes_cluster.k8s.endpoint
}

#Output kube_config
resource "local_file" "kube_config" {
    content = digitalocean_kubernetes_cluster.k8s.kube_config.0.raw_config
    filename = "kube_config.yaml"
}