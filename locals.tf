##################################################################################
# LOCALS
##################################################################################

locals {
  region = "ap-southeast-1"

  common_tags = {
    Name = "tsanghan-juice"
  }
  vpc_tags = {
    Name = "tsanghan-juice-vpc"
  }

  igw_tags = {
    Name = "tsanghan-juice-igw"
  }

  igw_rt_tags = {
    Name = "tsanghan-juice-igw-rt"
  }

  db_rt_tags = {
    Name = "tsanghan-juice-db-rt"
  }

  juice_sub_tags = {
    Name = "tsanghan-juice-1a"
  }

  eip_tags = {
    Name = "tsanghan-juice-eip"
  }

  random = {
    Name = "${random_id.server.hex}"
  }

  split_dns                    = split(".", var.origin_pool_dns_name)
  sliced_dns                   = slice(local.split_dns, 0, length(local.split_dns) - 2)
  trimmed_origin_pool_dns_name = join(".", local.sliced_dns)

}