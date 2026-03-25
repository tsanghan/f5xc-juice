#########################################
#  _                _                  _
# | |__   __ _  ___| | _____ _ __   __| |
# | '_ \ / _` |/ __| |/ / _ \ '_ \ / _` |
# | |_) | (_| | (__|   <  __/ | | | (_| |
# |_.__/ \__,_|\___|_|\_\___|_| |_|\__,_|
#
#########################################
# terraform {
#   backend "s3" {
#     bucket = "sctp-ce6-tfstate"
#     key    = "tsanghan-ce6-mod2_7.tfstate"
#     region = "ap-southeast-1"
#   }
# }

#########################################
#      _       _
#   __| | __ _| |_ __ _
#  / _` |/ _` | __/ _` |
# | (_| | (_| | || (_| |
#  \__,_|\__,_|\__\__,_|
#
#########################################
data "cloudinit_config" "juice_docker" {

  part {
    filename     = "hello-script.sh"
    content_type = "text/x-shellscript"

    content = file("cloud-init/run-script.sh")
  }

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = file("cloud-init/cloud-config.yaml")
  }
}

data "http" "myip" {
  url = "http://api.ipify.org"
}

##########################################
#             _                      _
#  _ __   ___| |___      _____  _ __| | __
# | '_ \ / _ \ __\ \ /\ / / _ \| '__| |/ /
# | | | |  __/ |_ \ V  V / (_) | |  |   <
# |_| |_|\___|\__| \_/\_/ \___/|_|  |_|\_\
#
##########################################
resource "aws_vpc" "juice" {
  cidr_block           = "10.255.0.0/16"
  enable_dns_hostnames = true

  tags = local.vpc_tags

}

resource "aws_internet_gateway" "juice" {
  vpc_id = aws_vpc.juice.id

  tags = local.igw_tags

}

resource "aws_subnet" "juice_sub" {
  cidr_block              = "10.255.1.0/24"
  vpc_id                  = aws_vpc.juice.id
  map_public_ip_on_launch = false
  availability_zone       = "ap-southeast-1a"

  tags = local.juice_sub_tags

}

# ROUTING #
resource "aws_route_table" "juice_rt" {
  vpc_id = aws_vpc.juice.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.juice.id
  }

  tags = local.igw_rt_tags

}

resource "aws_route_table_association" "juice_sub" {
  subnet_id      = aws_subnet.juice_sub.id
  route_table_id = aws_route_table.juice_rt.id
}

# SECURITY GROUPS #
# Nginx security group
resource "aws_security_group" "juice_sg" {
  name   = "web_server_sg"
  vpc_id = aws_vpc.juice.id

  # HTTP access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.response_body}/32"]
    description = "my IP Address"
  }

  ingress {
    from_port   = 1001
    to_port     = 1016
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.response_body}/32", "90.242.166.97/32", "111.223.104.76/32", "42.61.112.56/32"]
    description = "my IP Addresses"
  }

  ingress {
    from_port   = 1001
    to_port     = 1016
    protocol    = "tcp"
    cidr_blocks = var.ip_address_list

  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags

}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.juice.id
}

resource "aws_eip" "juice" {
  instance = aws_instance.juice.id
  domain   = "vpc"

  depends_on = [aws_internet_gateway.juice]

  tags = local.eip_tags
}

##########################################
#  _           _
# (_)_ __  ___| |_ __ _ _ __   ___ ___
# | | '_ \/ __| __/ _` | '_ \ / __/ _ \
# | | | | \__ \ || (_| | | | | (_|  __/
# |_|_| |_|___/\__\__,_|_| |_|\___\___|
#
##########################################
##################################################################################
# DATA
##################################################################################

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical

}

##################################################################################
# RESOURCES
##################################################################################

# RANDOM
resource "random_id" "server" {
  byte_length = 4
}


# KEY PAIRS
resource "aws_key_pair" "ubuntu" {
  key_name   = var.key_pair_name
  public_key = var.public_key
}

# INSTANCES #
resource "aws_instance" "juice" {
  ami                    = nonsensitive(data.aws_ami.ubuntu.id)
  instance_type          = "t2.large"
  subnet_id              = aws_subnet.juice_sub.id
  vpc_security_group_ids = [aws_security_group.juice_sg.id]
  key_name               = aws_key_pair.ubuntu.key_name
  user_data              = data.cloudinit_config.juice_docker.rendered

  tags = {
    Name = "tsanghan-juice-${local.random.Name}"
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
# data "aws_route53_zone" "training" {
#   name = "mylab.training"
# }

# resource "aws_route53_record" "juice" {
#   zone_id = data.aws_route53_zone.training.zone_id
#   name    = "juices-shop.mylab.training"
#   type    = "A"
#   ttl     = 300
#   records = [aws_eip.juice.public_ip]
# }

resource "volterra_dns_zone_record" "juice" {
  dns_zone_name = "learnf5.cloud"
  group_name    = "juice"
  rrset {
    description = "juice"
    ttl         = "300"
    a_record {
      #name   = local.trimmed_origin_pool_dns_name
      name   = "juice-origin"
      values = [aws_eip.juice.public_ip]
    }
  }
}

##########################################
#  _____ ______  ______
# |  ___| ___\ \/ / ___|
# | |_  |___ \\  / |
# |  _|  ___) /  \ |___
# |_|   |____/_/\_\____|
#
##########################################

module "health_check" {
  source            = "./modules/health_check"
  name              = format("%s-class-health-check-tf", var.name)
  namespace         = var.namespace
  health_check_path = var.health_check_path

  for_each = var.enable_lb_op_hc ? { "enabled" = true } : {}
}


module "dns_origin_pool" {
  source               = "./modules/origin_pool"
  name                 = format("%s-pool-tf", var.name)
  origin_pool_port     = var.origin_pool_port
  origin_pool_dns_name = var.origin_pool_dns_name
  health_check_name    = try(module.health_check["enabled"].health_check_name, null)
  namespace            = var.namespace
  depends_on           = [module.health_check]

  for_each = var.enable_lb_op_hc ? { "enabled" = true } : {}

}

module "load_balancer" {
  source      = "./modules/load_balancer"
  name        = format("%s-lb-tf", var.name)
  origin_pool = try(module.dns_origin_pool["enabled"].name, null)
  domains     = var.domains
  namespace   = var.namespace
  http_port   = var.http_port
  depends_on  = [module.dns_origin_pool]

  for_each = var.enable_lb_op_hc ? { "enabled" = true } : {}

}