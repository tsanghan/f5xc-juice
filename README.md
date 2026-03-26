# f5xc-juice

## Instructions for using this repo

### Pre-requisites
1. You will need to have Terraform and/or OpenTufu utility/utilities insatlled. This repo does work with Terraform and OpenTofu.
2. If you want to use the provided `Justfile` and/or `Taskfile.yaml` file/files, you will need to install `just` and/or `task`
3. Please do create a `.env` (or `.envrc` if you are using `direnv`) file from the sample `.env.example` file with approriate values.
4. Please also create `terraform.tfvars.tmpl` file from `terraform.tfvars.tmpl.example` and adjust the values to your needs. `update_ips.sh` will pull down the latest F5XC Network Cloud Reference RE IP addresses list, and create `terraform.tfvars` file from `terraform.tfvars.tmpl` template and add `ip_address_list` variable with RE IP addresses list.

If you want to swicth from using `Terraform` to `OpenTofu` or vice versa, you will need to do a `deep-clean` with `just`, `task` or `make`.
After that you will need to starts with `terraform init` or `tofu init`.

Enjoy.