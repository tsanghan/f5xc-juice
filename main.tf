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
  gzip          = false
  base64_encode = false

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

  tags = merge(local.vpc_tags, local.common_tags)

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

  tags = merge(local.juice_sub_tags, local.common_tags)

}

# ROUTING #
resource "aws_route_table" "juice_rt" {
  vpc_id = aws_vpc.juice.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.juice.id
  }

  tags = merge(local.igw_rt_tags, local.common_tags)

}

resource "aws_route_table_association" "juice_sub" {
  subnet_id      = aws_subnet.juice_sub.id
  route_table_id = aws_route_table.juice_rt.id
}

# SECURITY GROUPS #
resource "aws_security_group" "juice_sg" {
  name   = "F5XC Securing Security Group"
  vpc_id = aws_vpc.juice.id

  tags = merge({ Name = "F5XC Securing Security Group" }, local.common_tags)
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rules_tcp" {
  for_each = local.ingress_security_group_rules

  security_group_id = aws_security_group.juice_sg.id
  ip_protocol       = each.value.ip_protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  cidr_ipv4         = each.value.cidr_ipv4

  tags = merge(each.value.tags, local.common_tags)
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rules_ssh" {
  for_each = local.ssh_cidr_set

  security_group_id = aws_security_group.juice_sg.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = each.value

  tags = merge({ Name = "SSH" }, local.common_tags)
}

resource "aws_vpc_security_group_egress_rule" "egress_rule" {
  security_group_id = aws_security_group.juice_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

  tags = merge({ Name = "Allow All Traffic Outbound" }, local.common_tags)
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.juice.id
}

resource "aws_eip" "juice" {
  instance = aws_instance.juice.id
  domain   = "vpc"

  depends_on = [aws_internet_gateway.juice]

  tags = merge(local.eip_tags, local.common_tags)
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
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-*"]
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

  tags = merge(local.ec2_instance_tags, local.common_tags)

}

##########################################
#  ____  _   _ ____
# |  _ \| \ | / ___|
# | | | |  \| \___ \
# | |_| | |\  |___) |
# |____/|_| \_|____/
#
##########################################

# resource "f5xc_dns_zone_record" "juice" {
#   dns_zone_name = "learnf5.cloud"
#   group_name    = "juice"
#   rrset = {
#     description = "juice"
#     ttl         = "300"
#     type_record_set_choice = {
#       a_record = {
#         name   = "juice-origin"
#         values = [aws_eip.juice.public_ip]
#       }
#     }
#   }
# }
