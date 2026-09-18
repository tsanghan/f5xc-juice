##################################################################################
# LOCALS
##################################################################################

locals {
  f5xc_api_token = var.f5xc_api_token

  region = "ap-southeast-1"

  owner = "Wong_Tsang_Han"

  managed_by = "Terraform"

  resource-name-prefix = "F5XC-Securing-Class"

  ip_address_list = var.ip_address_list

  extra_cidrs_list = var.extra_cidrs != null ? split(",", var.extra_cidrs) : []

  local_cidr = var.in_github_action ? [] : ["${data.http.myip.response_body}/32"]

  ssh_cidr_set = toset(concat(local.local_cidr, local.extra_cidrs_list))

  final_cidrs_set = toset(concat(local.local_cidr, local.extra_cidrs_list, local.ip_address_list))

  common_tags = {
    Class      = "F5XC-Securing"
    Class_Date = formatdate("YYYY-MM-DD", timestamp())
    Managed_By = "${local.managed_by}"
    Owner      = "${local.owner}"
  }

  vpc_tags = {
    Name = "${local.resource-name-prefix}-VPC"
  }

  igw_tags = {
    Name = "${local.resource-name-prefix}-igw"
  }

  igw_rt_tags = {
    Name = "${local.resource-name-prefix}-igw-rt"
  }

  db_rt_tags = {
    Name = "${local.resource-name-prefix}-db-rt"
  }

  juice_sub_tags = {
    Name = "${local.resource-name-prefix}-1a"
  }

  eip_tags = {
    Name = "${local.resource-name-prefix}-eip"
  }

  ec2_instance_tags = {
    Name = "${local.resource-name-prefix}-ec2-instance"
  }

  random = {
    Name = "${random_id.server.hex}"
  }

  ingress_rules_data = {
    for i, v in [
      ["tcp", 3001, 3016, { Name = "TCP:3001->3016" }],
    ] : i => v
  }

  ip_address_map = {
    for i, v in tolist(local.final_cidrs_set) : i => v
  }

  ingress_security_group_rules = merge([
    for rule_key, rule_value in local.ingress_rules_data : {
      for address_key, address_value in local.ip_address_map :
      "rule_${rule_key}-addr_${address_key}" => {
        ip_protocol = rule_value[0]
        from_port   = rule_value[1]
        to_port     = rule_value[2]
        cidr_ipv4   = address_value
        tags        = rule_value[3]
      }
    }
  ]...)
}