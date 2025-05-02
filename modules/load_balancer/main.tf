terraform {
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.43"
    }
  }
}

resource "volterra_http_loadbalancer" "load_balancer" {
  lifecycle {
    ignore_changes = [labels]
  }
  name      = var.name
  namespace = var.namespace
  domains   = [var.domains]
  default_route_pools {
    pool {
      name      = var.origin_pool
      namespace = var.namespace
    }
    weight   = var.weight
    priority = var.priority
  }
  https_auto_cert {
    add_hsts = true
    http_redirect = true
    port = 443
    no_mtls = true
    default_loadbalancer = false
    enable_path_normalize = true
    tls_config {
        default_security = true
    }
    coalescing_options {
      default_coalescing = true
    }
    connection_idle_timeout = 120000
    http_protocol_options {
      http_protocol_enable_v1_v2 = true
    }
  }
  no_challenge = true
  round_robin  = true
  # multi_lb_app                    = true
  disable_rate_limit              = true
  service_policies_from_namespace = true
  disable_bot_defense             = true
  disable_waf                     = true
  user_id_client_ip               = true
}

