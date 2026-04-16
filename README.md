# f5xc-juice

## Instructions for using this repo

### Pre-requisites
1. You will need to have Terraform and/or OpenTufu utility/utilities insatlled. This repo does work with Terraform and OpenTofu.
2. If you want to use the provided `Justfile` file, you will need to install `just`.
3. Please do create a `.env` (or `.envrc` if you are using `direnv`) file from the sample `.env.example` file with approriate values.
4. Please also create `terraform.tfvars.tmpl` file from `terraform.tfvars.tmpl.example` and adjust the values to your needs. `update_ips.sh` will pull down the latest F5XC Network Cloud Reference RE IP addresses list, and create `terraform.tfvars` file from `terraform.tfvars.tmpl` template and add `ip_address_list` variable with RE IP addresses list.
5. The default `just` RECIPE will run `just -l` to show you the available RECIPE.
6. For autocompletion with RECIPE, run `source <(just --completions ${SHELL#/usr/bin/})`

If you want to swicth from using `Terraform` to `OpenTofu` or vice versa, you will need to do a `deep-clean` with `just`.
After that you will need to starts with `terraform init` or `tofu init`.

Enjoy.