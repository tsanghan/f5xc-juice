set shell := ["bash", "-c"]

update:
    ./update_ips.sh
    terraform fmt
    
clean:
    rm -f *.tfstate{,.backup}
    rm -f *.tfplan

deep-clean: clean
    rm -rf .terraform
    rm -f .terraform.lock.hcl

dot-env:
    sed -E "s%(=\"[^$].*\"|=\\$.*)%=\"\"%" <<<$(grep -v "^#" .envrc) | tee .env.example

user-data:
    terraform output -raw user_data | base64 -d | gunzip | bat