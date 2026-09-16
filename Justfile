set shell := ["bash", "-c"]

tf := require("terraform")
tofu := require("tofu")
# bat := require("bat")

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

check:
    terraform fmt
    # - diff variables.tf{,.example}
    # echo
    - diff locals.{tf,tofu}
    echo
    - diff providers.{tf,tofu}
    echo
    - diff backend.tf{,.example}
    echo

clean:
    #!/usr/bin/env bash
    echo "Running clean task with Bash..."

    files_to_remove=()
    while IFS= read -r -d '' f; do
        files_to_remove+=("$f")
    done < <(find . -type f -regextype posix-extended \
                -regex '.*\.(hcl|tfstate|backup)|\.?plan$' -print0)

    if [[ ${#files_to_remove[@]} -gt 0 ]]; then
        echo "Found ${#files_to_remove[@]} file(s) to delete:"
        printf '  %s\n' "${files_to_remove[@]}"
        rm -rf "${files_to_remove[@]}"
        echo "Deleting '.terraform' directory."
        rm -rf .terraform
        echo "Deletion complete."
    else
        echo "No matching files found; nothing to delete."
    fi

# Generate .env.example file
# gen-dot-env-example:
#     sed -E "s%(=\"[^$].*\"|=\\$.*)%=\"\"%" <<<$(grep -v "^#" .envrc) | tee .env.example

# Output user-date for viewing
# user-data:
#     terraform output -raw user_data | base64 -d | gunzip | {{bat}}

generate-tofu:
    #!/usr/bin/env bash
    sed "s/VERSION/$TERRAFORM_VER/" <templates/providers.tf.tmpl | tee providers.tf
    sed "s/VERSION/$OPENTOFU_VER/" <templates/providers.tf.tmpl | tee providers.tofu
    sed 's/Terraform/OpenTofu/' <locals.tf | tee locals.tofu
    # sed 's/"ssh-.*"/"<your_ssh_public_key>"/' <variables.tf | tee variables.tf.example