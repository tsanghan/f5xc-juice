set shell := ["bash", "-c"]

tf := require("terraform")
tofu := require("tofu")
bat := require("bat")

default:
    just -l

# terraform init plan & apply
build-tf: clean update-tf
    {{tf}} init
    {{tf}} plan -out xc-juice.tfplan
    {{tf}} apply -auto-approve xc-juice.tfplan

# tofu init plan & apply
build-tofu: clean update-tofu
    {{tofu}} init
    {{tofu}} plan -out xc-juice.tfplan
    {{tofu}} apply -auto-approve xc-juice.tfplan

# terraform destroy
destroy-tf:
    {{tf}} destroy -auto-approve

# tofu destroy
destroy-tofu:
    {{tofu}} destroy -auto-approve

update-tf:
    ./update_ips.sh
    {{tf}} fmt

update-tofu:
    ./update_ips.sh
    {{tofu}} fmt

clean:
    rm -f *.tfstate{,.backup}
    rm -f *.tfplan

deep-clean: clean
    rm -rf .terraform
    rm -f .terraform.lock.hcl

# Generate .env.example file
gen-dot-env-example:
    sed -E "s%(=\"[^$].*\"|=\\$.*)%=\"\"%" <<<$(grep -v "^#" .envrc) | tee .env.example

# Output user-date for viewing
user-data:
    terraform output -raw user_data | base64 -d | gunzip | {{bat}}