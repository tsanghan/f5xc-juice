# sctp-ce6-mod2.7

### Providers used in `provider.tf` terraform/tofu file.
1. aws
2. http
3. random
4. cloudinit

`Security Group` ingress cidr_blocks are automatically retrived from http provider.

For a working demo please see below.

```
Script started on 2024-06-26 13:41:38+08:00 [TERM="screen-256color" TTY="/dev/pts/3" COLUMNS="236" LINES="65"]
sctp-ce6-mod2.7sctp-ce6-mod2.7 on 🌱 main [📝🤷‍] via 💠 default
λ tofu init

Initializing the backend...

Successfully configured the backend "s3"! OpenTofu will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/random from the dependency lock file
- Reusing previous version of hashicorp/cloudinit from the dependency lock file
- Reusing previous version of hashicorp/http from the dependency lock file
- Installing hashicorp/aws v5.55.0...
- Installed hashicorp/aws v5.55.0 (signed, key ID 0C0AF313E5FD9F80)
- Installing hashicorp/random v3.6.2...
- Installed hashicorp/random v3.6.2 (signed, key ID 0C0AF313E5FD9F80)
- Installing hashicorp/cloudinit v2.3.4...
- Installed hashicorp/cloudinit v2.3.4 (signed, key ID 0C0AF313E5FD9F80)
- Installing hashicorp/http v3.4.3...
- Installed hashicorp/http v3.4.3 (signed, key ID 0C0AF313E5FD9F80)

Providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://opentofu.org/docs/cli/plugins/signing/

OpenTofu has been successfully initialized!

You may now begin working with OpenTofu. Try running "tofu plan" to see
any changes that are required for your infrastructure. All OpenTofu commands
should now work.

If you ever set or change modules or backend configuration for OpenTofu,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

sctp-ce6-mod2.7sctp-ce6-mod2.7 on 🌱 main [📝🤷‍] via 💠 default took 26s
λ tofu plan -out ec2.tfplan
tofudata.cloudinit_config.web_server: Reading...
data.http.myip: Reading...
data.cloudinit_config.web_server: Read complete after 0s [id=274610228]
data.aws_ami.ubuntu: Reading...
data.aws_ami.ubuntu: Read complete after 1s [id=ami-08c5f4ee271db0933]
data.http.myip: Read complete after 1s [id=http://api.ipify.org]

OpenTofu used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

OpenTofu will perform the following actions:

  # aws_instance.web_server will be created
  + resource "aws_instance" "web_server" {
      + ami                                  = "ami-08c5f4ee271db0933"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "tsanghan-ce6-tofu"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = (known after apply)
      + tags_all                             = (known after apply)
      + tenancy                              = (known after apply)
      + user_data                            = "1ed5a910bff1a93085453e642c2cc8b80dc57072"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)
    }

  # aws_internet_gateway.myapp will be created
  + resource "aws_internet_gateway" "myapp" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "tsanghan-ce6-igw"
        }
      + tags_all = {
          + "Name" = "tsanghan-ce6-igw"
        }
      + vpc_id   = (known after apply)
    }

  # aws_key_pair.ubuntu will be created
  + resource "aws_key_pair" "ubuntu" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "tsanghan-ce6-tofu"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICd8MjhHwvOszxaFSd2hAwXSQTGLJRxKkiAlvIdk1WBy eddsa-key-20240603"
      + tags_all        = (known after apply)
    }

  # aws_route_table.myapp will be created
  + resource "aws_route_table" "myapp" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = {
          + "Name" = "tsanghan-ce6-igw-rt"
        }
      + tags_all         = {
          + "Name" = "tsanghan-ce6-igw-rt"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.front_sub1 will be created
  + resource "aws_route_table_association" "front_sub1" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.web_server_sg will be created
  + resource "aws_security_group" "web_server_sg" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
          + {
              + cidr_blocks      = [
                  + "101.100.182.108/32",
                ]
              + description      = ""
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
        ]
      + name                   = "web_server_sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "tsanghan-ce6"
        }
      + tags_all               = {
          + "Name" = "tsanghan-ce6"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.front_sub1 will be created
  + resource "aws_subnet" "front_sub1" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-southeast-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.255.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "tsanghan-ce6-front1a"
        }
      + tags_all                                       = {
          + "Name" = "tsanghan-ce6-front1a"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_vpc.myapp will be created
  + resource "aws_vpc" "myapp" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.255.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Name" = "tsanghan-ce6-vpc"
        }
      + tags_all                             = {
          + "Name" = "tsanghan-ce6-vpc"
        }
    }

  # random_id.server will be created
  + resource "random_id" "server" {
      + b64_std     = (known after apply)
      + b64_url     = (known after apply)
      + byte_length = 4
      + dec         = (known after apply)
      + hex         = (known after apply)
      + id          = (known after apply)
    }

Plan: 9 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + instance = {
      + ami                                  = "ami-08c5f4ee271db0933"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + capacity_reservation_specification   = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_options                          = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + credit_specification                 = []
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_block_device                     = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enclave_options                      = (known after apply)
      + ephemeral_block_device               = (known after apply)
      + get_password_data                    = false
      + hibernation                          = null
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_market_options              = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "tsanghan-ce6-tofu"
      + launch_template                      = []
      + maintenance_options                  = (known after apply)
      + metadata_options                     = (known after apply)
      + monitoring                           = (known after apply)
      + network_interface                    = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_dns_name_options             = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + root_block_device                    = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = (known after apply)
      + tags_all                             = (known after apply)
      + tenancy                              = (known after apply)
      + timeouts                             = null
      + user_data                            = "1ed5a910bff1a93085453e642c2cc8b80dc57072"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + volume_tags                          = null
      + vpc_security_group_ids               = (known after apply)
    }

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Saved the plan to: ec2.tfplan

To perform exactly these actions, run the following command to apply:
    tofu apply "ec2.tfplan"

sctp-ce6-mod2.7sctp-ce6-mod2.7 on 🌱 main [📝🤷‍] via 💠 default took 2s
λ tofu apply "ec2.tfplantofu"ec2.tfplan"tofu apply "ec2.tfplan"tofu apply "ec2.tfplan"tofu"ec2.tfplan"
tofurandom_id.server: Creating...
random_id.server: Creation complete after 0s [id=3PjnUw]
aws_key_pair.ubuntu: Creating...
aws_vpc.myapp: Creating...
aws_key_pair.ubuntu: Creation complete after 1s [id=tsanghan-ce6-tofu]
aws_vpc.myapp: Still creating... [10s elapsed]
aws_vpc.myapp: Creation complete after 12s [id=vpc-076fcfcfc54a88339]
aws_internet_gateway.myapp: Creating...
aws_subnet.front_sub1: Creating...
aws_security_group.web_server_sg: Creating...
aws_internet_gateway.myapp: Creation complete after 0s [id=igw-088d99606f2601a96]
aws_route_table.myapp: Creating...
aws_route_table.myapp: Creation complete after 1s [id=rtb-00ff776bea2253a9b]
aws_security_group.web_server_sg: Creation complete after 2s [id=sg-0113682b4d5d7c7d9]
aws_subnet.front_sub1: Still creating... [10s elapsed]
aws_subnet.front_sub1: Creation complete after 11s [id=subnet-04ed05d7cb31f32f4]
aws_route_table_association.front_sub1: Creating...
aws_instance.web_server: Creating...
aws_route_table_association.front_sub1: Creation complete after 0s [id=rtbassoc-0ac5c614ecc62d2e2]
aws_instance.web_server: Still creating... [10s elapsed]
aws_instance.web_server: Still creating... [20s elapsed]
aws_instance.web_server: Still creating... [30s elapsed]
aws_instance.web_server: Creation complete after 31s [id=i-079ead0d62fabb58a]

Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Outputs:

instance = {
  "ami" = "ami-08c5f4ee271db0933"
  "arn" = "arn:aws:ec2:ap-southeast-1:255945442255:instance/i-079ead0d62fabb58a"
  "associate_public_ip_address" = true
  "availability_zone" = "ap-southeast-1a"
  "capacity_reservation_specification" = tolist([
    {
      "capacity_reservation_preference" = "open"
      "capacity_reservation_target" = tolist([])
    },
  ])
  "cpu_core_count" = 1
  "cpu_options" = tolist([
    {
      "amd_sev_snp" = ""
      "core_count" = 1
      "threads_per_core" = 1
    },
  ])
  "cpu_threads_per_core" = 1
  "credit_specification" = tolist([
    {
      "cpu_credits" = "standard"
    },
  ])
  "disable_api_stop" = false
  "disable_api_termination" = false
  "ebs_block_device" = toset([])
  "ebs_optimized" = false
  "enclave_options" = tolist([
    {
      "enabled" = false
    },
  ])
  "ephemeral_block_device" = toset([])
  "get_password_data" = false
  "hibernation" = false
  "host_id" = ""
  "host_resource_group_arn" = tostring(null)
  "iam_instance_profile" = ""
  "id" = "i-079ead0d62fabb58a"
  "instance_initiated_shutdown_behavior" = "stop"
  "instance_lifecycle" = ""
  "instance_market_options" = tolist([])
  "instance_state" = "running"
  "instance_type" = "t2.micro"
  "ipv6_address_count" = 0
  "ipv6_addresses" = tolist([])
  "key_name" = "tsanghan-ce6-tofu"
  "launch_template" = tolist([])
  "maintenance_options" = tolist([
    {
      "auto_recovery" = "default"
    },
  ])
  "metadata_options" = tolist([
    {
      "http_endpoint" = "enabled"
      "http_protocol_ipv6" = "disabled"
      "http_put_response_hop_limit" = 2
      "http_tokens" = "required"
      "instance_metadata_tags" = "disabled"
    },
  ])
  "monitoring" = false
  "network_interface" = toset([])
  "outpost_arn" = ""
  "password_data" = ""
  "placement_group" = ""
  "placement_partition_number" = 0
  "primary_network_interface_id" = "eni-0dfae1203eecf2b00"
  "private_dns" = "ip-10-255-1-239.ap-southeast-1.compute.internal"
  "private_dns_name_options" = tolist([
    {
      "enable_resource_name_dns_a_record" = false
      "enable_resource_name_dns_aaaa_record" = false
      "hostname_type" = "ip-name"
    },
  ])
  "private_ip" = "10.255.1.239"
  "public_dns" = "ec2-13-228-28-80.ap-southeast-1.compute.amazonaws.com"
  "public_ip" = "13.228.28.80"
  "root_block_device" = tolist([
    {
      "delete_on_termination" = true
      "device_name" = "/dev/sda1"
      "encrypted" = false
      "iops" = 3000
      "kms_key_id" = ""
      "tags" = tomap({})
      "tags_all" = tomap({})
      "throughput" = 125
      "volume_id" = "vol-04be10131f5a54829"
      "volume_size" = 8
      "volume_type" = "gp3"
    },
  ])
  "secondary_private_ips" = toset([])
  "security_groups" = toset([])
  "source_dest_check" = true
  "spot_instance_request_id" = ""
  "subnet_id" = "subnet-04ed05d7cb31f32f4"
  "tags" = tomap({
    "Name" = "tsanghan-ce6-dcf8e753"
  })
  "tags_all" = tomap({
    "Name" = "tsanghan-ce6-dcf8e753"
  })
  "tenancy" = "default"
  "timeouts" = null /* object */
  "user_data" = "1ed5a910bff1a93085453e642c2cc8b80dc57072"
  "user_data_base64" = tostring(null)
  "user_data_replace_on_change" = false
  "volume_tags" = tomap(null) /* of string */
  "vpc_security_group_ids" = toset([
    "sg-0113682b4d5d7c7d9",
  ])
}

sctp-ce6-mod2.7sctp-ce6-mod2.7 on 🌱 main [📝🤷‍] via 💠 default took 56s
λ PUBLIC_DNS=$(tofu output -json | jq -Mr '.instance.value.public_dns') ; echo $PUBLIC_DNS
ec2-13-228-28-80.ap-southeast-1.compute.amazonaws.com

sctp-ce6-mod2.7sctp-ce6-mod2.7 on 🌱 main [📝🤷‍] via 💠 default
λ while : ; do echo "testing..." ; nc -z -w5 $PUBLIC_DNS 80; if [[ $? == '0' ]]; then echo 'Port 80 up!!!' ; break; fi ; sleep 5; done
testing...
testing...
testing...
testing...
testing...
testing...
testing...
testing...
testing...
testing...
testing...
testing...
testing...
testing...
testing...
testing...
testing...
testing...
Port 80 up!!!

sctp-ce6-mod2.7sctp-ce6-mod2.7 on 🌱 main [📝🤷‍] via 💠 default took 1m25s
λ curl -s $PUBLIC_DNS

curl<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<h1>This is added by Cloud-init.</h1>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

sctp-ce6-mod2.7sctp-ce6-mod2.7 on 🌱 main [📝🤷‍] via 💠 default
λ ssh ubuntu@$PUBLIC_DNS "curl -s api.ipify.org"
ubuntu@$PUBLIC_DNSWarning: Permanently added 'ec2-13-228-28-80.ap-southeast-1.compute.amazonaws.com' (ED25519) to the list of known hosts.
13.228.28.80

sctp-ce6-mod2.7sctp-ce6-mod2.7 on 🌱 main [📝🤷‍] via 💠 default took 2s
λ ssh-keygen -R $PUBLIC_DNS
ssh-keygen# Host ec2-13-228-28-80.ap-southeast-1.compute.amazonaws.com found: line 43
/home/localadmin/.ssh/known_hosts updated.
Original contents retained as /home/localadmin/.ssh/known_hosts.old

sctp-ce6-mod2.7sctp-ce6-mod2.7 on 🌱 main [📝🤷‍] via 💠 default
λ tofu destroy -auto-approve
tofudata.http.myip: Reading...
random_id.server: Refreshing state... [id=3PjnUw]
data.cloudinit_config.web_server: Reading...
data.cloudinit_config.web_server: Read complete after 0s [id=274610228]
aws_key_pair.ubuntu: Refreshing state... [id=tsanghan-ce6-tofu]
data.aws_ami.ubuntu: Reading...
aws_vpc.myapp: Refreshing state... [id=vpc-076fcfcfc54a88339]
data.http.myip: Read complete after 0s [id=http://api.ipify.org]
data.aws_ami.ubuntu: Read complete after 0s [id=ami-08c5f4ee271db0933]
aws_internet_gateway.myapp: Refreshing state... [id=igw-088d99606f2601a96]
aws_subnet.front_sub1: Refreshing state... [id=subnet-04ed05d7cb31f32f4]
aws_security_group.web_server_sg: Refreshing state... [id=sg-0113682b4d5d7c7d9]
aws_route_table.myapp: Refreshing state... [id=rtb-00ff776bea2253a9b]
aws_instance.web_server: Refreshing state... [id=i-079ead0d62fabb58a]
aws_route_table_association.front_sub1: Refreshing state... [id=rtbassoc-0ac5c614ecc62d2e2]

OpenTofu used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

OpenTofu will perform the following actions:

  # aws_instance.web_server will be destroyed
  - resource "aws_instance" "web_server" {
      - ami                                  = "ami-08c5f4ee271db0933" -> null
      - arn                                  = "arn:aws:ec2:ap-southeast-1:255945442255:instance/i-079ead0d62fabb58a" -> null
      - associate_public_ip_address          = true -> null
      - availability_zone                    = "ap-southeast-1a" -> null
      - cpu_core_count                       = 1 -> null
      - cpu_threads_per_core                 = 1 -> null
      - disable_api_stop                     = false -> null
      - disable_api_termination              = false -> null
      - ebs_optimized                        = false -> null
      - get_password_data                    = false -> null
      - hibernation                          = false -> null
      - id                                   = "i-079ead0d62fabb58a" -> null
      - instance_initiated_shutdown_behavior = "stop" -> null
      - instance_state                       = "running" -> null
      - instance_type                        = "t2.micro" -> null
      - ipv6_address_count                   = 0 -> null
      - ipv6_addresses                       = [] -> null
      - key_name                             = "tsanghan-ce6-tofu" -> null
      - monitoring                           = false -> null
      - placement_partition_number           = 0 -> null
      - primary_network_interface_id         = "eni-0dfae1203eecf2b00" -> null
      - private_dns                          = "ip-10-255-1-239.ap-southeast-1.compute.internal" -> null
      - private_ip                           = "10.255.1.239" -> null
      - public_dns                           = "ec2-13-228-28-80.ap-southeast-1.compute.amazonaws.com" -> null
      - public_ip                            = "13.228.28.80" -> null
      - secondary_private_ips                = [] -> null
      - security_groups                      = [] -> null
      - source_dest_check                    = true -> null
      - subnet_id                            = "subnet-04ed05d7cb31f32f4" -> null
      - tags                                 = {
          - "Name" = "tsanghan-ce6-dcf8e753"
        } -> null
      - tags_all                             = {
          - "Name" = "tsanghan-ce6-dcf8e753"
        } -> null
      - tenancy                              = "default" -> null
      - user_data                            = "1ed5a910bff1a93085453e642c2cc8b80dc57072" -> null
      - user_data_replace_on_change          = false -> null
      - vpc_security_group_ids               = [
          - "sg-0113682b4d5d7c7d9",
        ] -> null

      - capacity_reservation_specification {
          - capacity_reservation_preference = "open" -> null
        }

      - cpu_options {
          - core_count       = 1 -> null
          - threads_per_core = 1 -> null
        }

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      - enclave_options {
          - enabled = false -> null
        }

      - maintenance_options {
          - auto_recovery = "default" -> null
        }

      - metadata_options {
          - http_endpoint               = "enabled" -> null
          - http_protocol_ipv6          = "disabled" -> null
          - http_put_response_hop_limit = 2 -> null
          - http_tokens                 = "required" -> null
          - instance_metadata_tags      = "disabled" -> null
        }

      - private_dns_name_options {
          - enable_resource_name_dns_a_record    = false -> null
          - enable_resource_name_dns_aaaa_record = false -> null
          - hostname_type                        = "ip-name" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - device_name           = "/dev/sda1" -> null
          - encrypted             = false -> null
          - iops                  = 3000 -> null
          - tags                  = {} -> null
          - tags_all              = {} -> null
          - throughput            = 125 -> null
          - volume_id             = "vol-04be10131f5a54829" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp3" -> null
        }
    }

  # aws_internet_gateway.myapp will be destroyed
  - resource "aws_internet_gateway" "myapp" {
      - arn      = "arn:aws:ec2:ap-southeast-1:255945442255:internet-gateway/igw-088d99606f2601a96" -> null
      - id       = "igw-088d99606f2601a96" -> null
      - owner_id = "255945442255" -> null
      - tags     = {
          - "Name" = "tsanghan-ce6-igw"
        } -> null
      - tags_all = {
          - "Name" = "tsanghan-ce6-igw"
        } -> null
      - vpc_id   = "vpc-076fcfcfc54a88339" -> null
    }

  # aws_key_pair.ubuntu will be destroyed
  - resource "aws_key_pair" "ubuntu" {
      - arn         = "arn:aws:ec2:ap-southeast-1:255945442255:key-pair/tsanghan-ce6-tofu" -> null
      - fingerprint = "/riqDNtKW2aFLImyHuTWT2v3Ydl2t5EVp9tdpgby2xU=" -> null
      - id          = "tsanghan-ce6-tofu" -> null
      - key_name    = "tsanghan-ce6-tofu" -> null
      - key_pair_id = "key-082af0ed190e4482b" -> null
      - key_type    = "ed25519" -> null
      - public_key  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICd8MjhHwvOszxaFSd2hAwXSQTGLJRxKkiAlvIdk1WBy eddsa-key-20240603" -> null
      - tags        = {} -> null
      - tags_all    = {} -> null
    }

  # aws_route_table.myapp will be destroyed
  - resource "aws_route_table" "myapp" {
      - arn              = "arn:aws:ec2:ap-southeast-1:255945442255:route-table/rtb-00ff776bea2253a9b" -> null
      - id               = "rtb-00ff776bea2253a9b" -> null
      - owner_id         = "255945442255" -> null
      - propagating_vgws = [] -> null
      - route            = [
          - {
              - carrier_gateway_id         = ""
              - cidr_block                 = "0.0.0.0/0"
              - core_network_arn           = ""
              - destination_prefix_list_id = ""
              - egress_only_gateway_id     = ""
              - gateway_id                 = "igw-088d99606f2601a96"
              - ipv6_cidr_block            = ""
              - local_gateway_id           = ""
              - nat_gateway_id             = ""
              - network_interface_id       = ""
              - transit_gateway_id         = ""
              - vpc_endpoint_id            = ""
              - vpc_peering_connection_id  = ""
            },
        ] -> null
      - tags             = {
          - "Name" = "tsanghan-ce6-igw-rt"
        } -> null
      - tags_all         = {
          - "Name" = "tsanghan-ce6-igw-rt"
        } -> null
      - vpc_id           = "vpc-076fcfcfc54a88339" -> null
    }

  # aws_route_table_association.front_sub1 will be destroyed
  - resource "aws_route_table_association" "front_sub1" {
      - id             = "rtbassoc-0ac5c614ecc62d2e2" -> null
      - route_table_id = "rtb-00ff776bea2253a9b" -> null
      - subnet_id      = "subnet-04ed05d7cb31f32f4" -> null
    }

  # aws_security_group.web_server_sg will be destroyed
  - resource "aws_security_group" "web_server_sg" {
      - arn                    = "arn:aws:ec2:ap-southeast-1:255945442255:security-group/sg-0113682b4d5d7c7d9" -> null
      - description            = "Managed by Terraform" -> null
      - egress                 = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 0
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "-1"
              - security_groups  = []
              - self             = false
              - to_port          = 0
            },
        ] -> null
      - id                     = "sg-0113682b4d5d7c7d9" -> null
      - ingress                = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 443
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 443
            },
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 80
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 80
            },
          - {
              - cidr_blocks      = [
                  - "101.100.182.108/32",
                ]
              - description      = ""
              - from_port        = 22
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 22
            },
        ] -> null
      - name                   = "web_server_sg" -> null
      - owner_id               = "255945442255" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {
          - "Name" = "tsanghan-ce6"
        } -> null
      - tags_all               = {
          - "Name" = "tsanghan-ce6"
        } -> null
      - vpc_id                 = "vpc-076fcfcfc54a88339" -> null
    }

  # aws_subnet.front_sub1 will be destroyed
  - resource "aws_subnet" "front_sub1" {
      - arn                                            = "arn:aws:ec2:ap-southeast-1:255945442255:subnet/subnet-04ed05d7cb31f32f4" -> null
      - assign_ipv6_address_on_creation                = false -> null
      - availability_zone                              = "ap-southeast-1a" -> null
      - availability_zone_id                           = "apse1-az2" -> null
      - cidr_block                                     = "10.255.1.0/24" -> null
      - enable_dns64                                   = false -> null
      - enable_lni_at_device_index                     = 0 -> null
      - enable_resource_name_dns_a_record_on_launch    = false -> null
      - enable_resource_name_dns_aaaa_record_on_launch = false -> null
      - id                                             = "subnet-04ed05d7cb31f32f4" -> null
      - ipv6_native                                    = false -> null
      - map_customer_owned_ip_on_launch                = false -> null
      - map_public_ip_on_launch                        = true -> null
      - owner_id                                       = "255945442255" -> null
      - private_dns_hostname_type_on_launch            = "ip-name" -> null
      - tags                                           = {
          - "Name" = "tsanghan-ce6-front1a"
        } -> null
      - tags_all                                       = {
          - "Name" = "tsanghan-ce6-front1a"
        } -> null
      - vpc_id                                         = "vpc-076fcfcfc54a88339" -> null
    }

  # aws_vpc.myapp will be destroyed
  - resource "aws_vpc" "myapp" {
      - arn                                  = "arn:aws:ec2:ap-southeast-1:255945442255:vpc/vpc-076fcfcfc54a88339" -> null
      - assign_generated_ipv6_cidr_block     = false -> null
      - cidr_block                           = "10.255.0.0/16" -> null
      - default_network_acl_id               = "acl-0121d3e005361279b" -> null
      - default_route_table_id               = "rtb-02f1577bde6fe3cad" -> null
      - default_security_group_id            = "sg-04dca9fe0f382c82d" -> null
      - dhcp_options_id                      = "dopt-0e5da6d5b4fc655d7" -> null
      - enable_dns_hostnames                 = true -> null
      - enable_dns_support                   = true -> null
      - enable_network_address_usage_metrics = false -> null
      - id                                   = "vpc-076fcfcfc54a88339" -> null
      - instance_tenancy                     = "default" -> null
      - ipv6_netmask_length                  = 0 -> null
      - main_route_table_id                  = "rtb-02f1577bde6fe3cad" -> null
      - owner_id                             = "255945442255" -> null
      - tags                                 = {
          - "Name" = "tsanghan-ce6-vpc"
        } -> null
      - tags_all                             = {
          - "Name" = "tsanghan-ce6-vpc"
        } -> null
    }

  # random_id.server will be destroyed
  - resource "random_id" "server" {
      - b64_std     = "3PjnUw==" -> null
      - b64_url     = "3PjnUw" -> null
      - byte_length = 4 -> null
      - dec         = "3707299667" -> null
      - hex         = "dcf8e753" -> null
      - id          = "3PjnUw" -> null
    }

Plan: 0 to add, 0 to change, 9 to destroy.

Changes to Outputs:
  - instance = {
      - ami                                  = "ami-08c5f4ee271db0933"
      - arn                                  = "arn:aws:ec2:ap-southeast-1:255945442255:instance/i-079ead0d62fabb58a"
      - associate_public_ip_address          = true
      - availability_zone                    = "ap-southeast-1a"
      - capacity_reservation_specification   = [
          - {
              - capacity_reservation_preference = "open"
              - capacity_reservation_target     = []
            },
        ]
      - cpu_core_count                       = 1
      - cpu_options                          = [
          - {
              - amd_sev_snp      = ""
              - core_count       = 1
              - threads_per_core = 1
            },
        ]
      - cpu_threads_per_core                 = 1
      - credit_specification                 = [
          - {
              - cpu_credits = "standard"
            },
        ]
      - disable_api_stop                     = false
      - disable_api_termination              = false
      - ebs_block_device                     = []
      - ebs_optimized                        = false
      - enclave_options                      = [
          - {
              - enabled = false
            },
        ]
      - ephemeral_block_device               = []
      - get_password_data                    = false
      - hibernation                          = false
      - host_id                              = ""
      - host_resource_group_arn              = null
      - iam_instance_profile                 = ""
      - id                                   = "i-079ead0d62fabb58a"
      - instance_initiated_shutdown_behavior = "stop"
      - instance_lifecycle                   = ""
      - instance_market_options              = []
      - instance_state                       = "running"
      - instance_type                        = "t2.micro"
      - ipv6_address_count                   = 0
      - ipv6_addresses                       = []
      - key_name                             = "tsanghan-ce6-tofu"
      - launch_template                      = []
      - maintenance_options                  = [
          - {
              - auto_recovery = "default"
            },
        ]
      - metadata_options                     = [
          - {
              - http_endpoint               = "enabled"
              - http_protocol_ipv6          = "disabled"
              - http_put_response_hop_limit = 2
              - http_tokens                 = "required"
              - instance_metadata_tags      = "disabled"
            },
        ]
      - monitoring                           = false
      - network_interface                    = []
      - outpost_arn                          = ""
      - password_data                        = ""
      - placement_group                      = ""
      - placement_partition_number           = 0
      - primary_network_interface_id         = "eni-0dfae1203eecf2b00"
      - private_dns                          = "ip-10-255-1-239.ap-southeast-1.compute.internal"
      - private_dns_name_options             = [
          - {
              - enable_resource_name_dns_a_record    = false
              - enable_resource_name_dns_aaaa_record = false
              - hostname_type                        = "ip-name"
            },
        ]
      - private_ip                           = "10.255.1.239"
      - public_dns                           = "ec2-13-228-28-80.ap-southeast-1.compute.amazonaws.com"
      - public_ip                            = "13.228.28.80"
      - root_block_device                    = [
          - {
              - delete_on_termination = true
              - device_name           = "/dev/sda1"
              - encrypted             = false
              - iops                  = 3000
              - kms_key_id            = ""
              - tags                  = {}
              - tags_all              = {}
              - throughput            = 125
              - volume_id             = "vol-04be10131f5a54829"
              - volume_size           = 8
              - volume_type           = "gp3"
            },
        ]
      - secondary_private_ips                = []
      - security_groups                      = []
      - source_dest_check                    = true
      - spot_instance_request_id             = ""
      - subnet_id                            = "subnet-04ed05d7cb31f32f4"
      - tags                                 = {
          - Name = "tsanghan-ce6-dcf8e753"
        }
      - tags_all                             = {
          - Name = "tsanghan-ce6-dcf8e753"
        }
      - tenancy                              = "default"
      - timeouts                             = null
      - user_data                            = "1ed5a910bff1a93085453e642c2cc8b80dc57072"
      - user_data_base64                     = null
      - user_data_replace_on_change          = false
      - volume_tags                          = null
      - vpc_security_group_ids               = [
          - "sg-0113682b4d5d7c7d9",
        ]
    } -> null
aws_route_table_association.front_sub1: Destroying... [id=rtbassoc-0ac5c614ecc62d2e2]
aws_instance.web_server: Destroying... [id=i-079ead0d62fabb58a]
aws_route_table_association.front_sub1: Destruction complete after 0s
aws_route_table.myapp: Destroying... [id=rtb-00ff776bea2253a9b]
aws_route_table.myapp: Destruction complete after 0s
aws_internet_gateway.myapp: Destroying... [id=igw-088d99606f2601a96]
aws_instance.web_server: Still destroying... [id=i-079ead0d62fabb58a, 10s elapsed]
aws_internet_gateway.myapp: Still destroying... [id=igw-088d99606f2601a96, 10s elapsed]
aws_instance.web_server: Still destroying... [id=i-079ead0d62fabb58a, 20s elapsed]
aws_internet_gateway.myapp: Still destroying... [id=igw-088d99606f2601a96, 20s elapsed]
aws_instance.web_server: Still destroying... [id=i-079ead0d62fabb58a, 30s elapsed]
aws_internet_gateway.myapp: Still destroying... [id=igw-088d99606f2601a96, 30s elapsed]
aws_instance.web_server: Still destroying... [id=i-079ead0d62fabb58a, 40s elapsed]
aws_internet_gateway.myapp: Still destroying... [id=igw-088d99606f2601a96, 40s elapsed]
aws_instance.web_server: Still destroying... [id=i-079ead0d62fabb58a, 50s elapsed]
aws_internet_gateway.myapp: Still destroying... [id=igw-088d99606f2601a96, 50s elapsed]
aws_instance.web_server: Still destroying... [id=i-079ead0d62fabb58a, 1m0s elapsed]
aws_internet_gateway.myapp: Still destroying... [id=igw-088d99606f2601a96, 1m0s elapsed]
aws_internet_gateway.myapp: Destruction complete after 1m8s
aws_instance.web_server: Still destroying... [id=i-079ead0d62fabb58a, 1m10s elapsed]
aws_instance.web_server: Destruction complete after 1m10s
aws_key_pair.ubuntu: Destroying... [id=tsanghan-ce6-tofu]
aws_subnet.front_sub1: Destroying... [id=subnet-04ed05d7cb31f32f4]
random_id.server: Destroying... [id=3PjnUw]
aws_security_group.web_server_sg: Destroying... [id=sg-0113682b4d5d7c7d9]
random_id.server: Destruction complete after 0s
aws_key_pair.ubuntu: Destruction complete after 0s
aws_subnet.front_sub1: Destruction complete after 0s
aws_security_group.web_server_sg: Destruction complete after 0s
aws_vpc.myapp: Destroying... [id=vpc-076fcfcfc54a88339]
aws_vpc.myapp: Destruction complete after 1s

Destroy complete! Resources: 9 destroyed.

sctp-ce6-mod2.7sctp-ce6-mod2.7 on 🌱 main [📝🤷‍] via 💠 default took 1m15s
λ exit

Script done on 2024-06-26 13:46:59+08:00 [COMMAND_EXIT_CODE="0"]

```