##########################################
#  _____ ______  ______
# |  ___| ___\ \/ / ___|
# | |_  |___ \\  / |
# |  _|  ___) /  \ |___
# |_|   |____/_/\_\____|
#
##########################################

locals {

  student_name = "tsanghan"

  lb_info = {
    name        = "${local.student_name}-http-lb"
    namespace   = "${local.student_name}"
    description = "${local.student_name}-lb managed by ${local.managed_by}"
    domains     = ["${local.student_name}.dev.learnf5.cloud"]
    port        = 443
  }

  pool_info = {
    name                   = "${local.student_name}-pool"
    namespace              = "${local.student_name}"
    description            = "${local.student_name}-pool managed by ${local.managed_by}"
    weight                 = 1
    priority               = 1
    port                   = 3001
    loadbalancer_algorithm = ["ROUND_ROBIN"]
    endpoint_selection     = ["LOCAL_PREFERRED"]
    public_dns_name        = "juice-origin.learnf5.cloud"
  }

  hc_info = {
    name                = "${local.student_name}-hc"
    namespace           = "${local.student_name}"
    description         = "${local.student_name}-hc managed by ${local.managed_by}"
    timeout             = 3
    interval            = 15
    unhealthy_threshold = 1
    healthy_threshold   = 3
    health_check_path   = "/"
  }

}

##########################################
#  ____  _   _ ____
# |  _ \| \ | / ___|
# | | | |  \| \___ \
# | |_| | |\  |___) |
# |____/|_| \_|____/
#
##########################################

resource "f5xc_dns_zone_record" "juice" {
  dns_zone_name = "learnf5.cloud"
  group_name    = "juice"
  rrset = {
    description = "juice"
    ttl         = "300"
    type_record_set_choice = {
      a_record = {
        name   = "juice-origin"
        values = [aws_eip.juice.public_ip]
      }
    }
  }
}

##########################################
#  _     ____
# | |   | __ )
# | |   |  _ \
# | |___| |_) |
# |_____|____/
#
##########################################

resource "f5xc_http_loadbalancer" "this" {
  name        = local.lb_info["name"]
  namespace   = local.lb_info["namespace"]
  description = local.lb_info["description"]
  domains     = local.lb_info["domains"]

  labels = {
    tsanghan-key = "tsanghan-value"
  }

  annotations = {
    owner = "tsanghan"
  }

  loadbalancer_type_choice = {
    https_auto_cert = {
      add_hsts      = true
      http_redirect = true
      port_choice = {
        port = local.lb_info["port"]
      }
      mtls_choice = {
        no_mtls = true
      }
      path_normalize_choice = {
        enable_path_normalize = true
      }
    }
  }

  advertise_choice = {
    advertise_on_public_default_vip = true
  }

  default_route_pools = [
    {
      pool_choice = {
        pool = {
          name      = f5xc_origin_pool.this.name
          namespace = f5xc_origin_pool.this.namespace
        }
      }
      weight   = local.pool_info["weight"]
      priority = local.pool_info["priority"]
    }
  ]

  waf_choice = {
    disable_waf = true
  }

  challenge_type_choice = {
    no_challenge = true
  }

  user_id_choice = {
    user_id_client_ip = true
  }

  rate_limit_choice = {
    disable_rate_limit = true
  }

  service_policy_choice = {
    no_service_policies = true
  }
  hash_policy_choice = {
    round_robin = true
  }

  trust_client_ip_headers_choice = {
    disable_trust_client_ip_headers = true
  }

  malicious_user_detection_choice = {
    disable_malicious_user_detection = true
  }

  api_discovery_choice = {
    disable_api_discovery = true
  }

  bot_defense_choice = {
    disable_bot_defense = true
  }

  api_definition_choice = {
    disable_api_definition = true
  }

  sensitive_data_policy_choice = {
    default_sensitive_data_policy = true
  }

  api_testing_choice = {
    disable_api_testing = true
  }

  threat_mesh_choice = {
    disable_threat_mesh = true
  }

  malware_protection_choice = {
    disable_malware_protection = true
  }

  lifecycle {
    ignore_changes = [labels]
  }
}

##########################################
#   ___  ____
#  / _ \|  _ \
# | | | | |_) |
# | |_| |  __/
#  \___/|_|
#
##########################################

resource "f5xc_origin_pool" "this" {
  name                   = local.pool_info["name"]
  namespace              = local.pool_info["namespace"]
  description            = local.pool_info["description"]
  loadbalancer_algorithm = local.pool_info["loadbalancer_algorithm"]
  endpoint_selection     = local.pool_info["endpoint_selection"]

  labels = {
    tsanghan-key = "tsanghan-value"
  }

  annotations = {
    owner = "tsanghan"
  }

  port_choice = {
    port = local.pool_info["port"]
  }

  tls_choice = {
    no_tls = true
  }

  upstream_conn_pool_reuse_type = {
    map_downstream_to_upstream_conn_pool_type_choice = {
      disable_conn_pool_reuse = true
    }
  }

  origin_servers = [
    {
      choice = {
        public_name = {
          dns_name = local.pool_info["public_dns_name"]
        }
      }
    }
  ]

  healthcheck = [
    {
      name      = f5xc_healthcheck.this.name
      namespace = local.hc_info["namespace"]
    }
  ]

  lifecycle {
    ignore_changes = [labels]
  }
}

##########################################
#  _   _  ____
# | | | |/ ___|
# | |_| | |
# |  _  | |___
# |_| |_|\____|
#
##########################################

resource "f5xc_healthcheck" "this" {
  name        = local.hc_info["name"]
  namespace   = local.hc_info["namespace"]
  description = local.hc_info["description"]

  labels = {
    tsanghan-key = "tsanghan-value"
  }

  annotations = {
    owner = "tsanghan"
  }

  timeout             = local.hc_info["timeout"]
  interval            = local.hc_info["interval"]
  unhealthy_threshold = local.hc_info["unhealthy_threshold"]
  healthy_threshold   = local.hc_info["healthy_threshold"]

  health_check_choice = {
    http_health_check = {
      host_header_choice = {
        host_header = local.pool_info["public_dns_name"]
      }
      path = local.hc_info["health_check_path"]
    }
    request_headers_to_remove = ["User-Agent"]
    use_http2                 = false
    expected_status_codes     = ["200"]
  }

  lifecycle {
    ignore_changes = [labels]
  }
}

# resource "f5xc_virtual_site" "this" {
#   name      = "${local.student_name}-vsite"
#   namespace = local.student_name
#   site_selector = {
#     expressions = ["${local.student_name}-key in ${local.student_name}-value"]
#   }
#   site_type = ["CE"]
# }

# resource "f5xc_virtual_k8s" "this" {
#   name      = "${local.student_name}-vk8s"
#   namespace = local.student_name
# }