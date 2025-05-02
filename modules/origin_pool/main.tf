terraform {
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.43"
    }
  }
}

resource "volterra_origin_pool" "volterra_dns_origin_pool" {
  name                   = var.name
  namespace              = var.namespace
  loadbalancer_algorithm = var.loadbalancer_algorithm
  healthcheck {
    name      = var.health_check_name
    namespace = var.namespace
  }
  origin_servers {
    public_name {
      dns_name = var.origin_pool_dns_name
    }
  }
  port               = var.origin_pool_port
  no_tls             = true
  endpoint_selection = "LOCAL_PREFERRED"
}

