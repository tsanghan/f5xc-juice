update:
    ./update_ips.sh
    terraform fmt
    
clean:
    rm -f *.tfstate
    rm -f *.tfstate.backup
    rm -f *.tfplan

deep-clean:
    just clean
    rm -rf .terraform
    rm -f .terraform.lock.hcl

dot-env:
    bash -c 'sed -E "s%(=\"[^$].*\"|=\\$.*)%=\"\"%" <<<$(grep -v "^#" .envrc)' | tee .env.example

user-data:
    terraform output user_data | tr -d '"' | base64 -d | gunzip | bat