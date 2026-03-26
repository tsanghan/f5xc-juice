#!/usr/bin/env bash

# echo "The script you are running has:"
# echo "basename: [$(basename "$0")]"
# echo "dirname : [$(dirname "$0")]"
# echo "pwd     : [$(pwd)]"

# fetch json IP Addresses list
IPADDRESS_RAW=$(curl -sSL https://docs.cloud.f5.com/docs-v2/downloads/platform/reference/network-cloud-ref/ips-domains.json | \
    jq -Mr '.services.regional_edges.regions | 
            .asia.ipv4_cidrs[],.europe.ipv4_cidrs[],.americas.ipv4_cidrs[]'| sort -n)

# Build HCL list: ["1.2.3.4","5.6.7.8"]
# IPADDRESS_HCL_LIST=$(printf '%s\n' "$IPADDRESS_RAW" | jq -R -s -c 'split("\n") | map(select(length>0))')
IPADDRESS_LIST=$(awk 'NF{a[++n]=$0} END {for (i=1;i<=n;i++) {printf "\t\"%s\"%s\n", a[i], (i<n?",":"")}}' <<<"$IPADDRESS_RAW")

# Write terraform.tfvars

if [ -e terraform.tfvars ]; then
    : > terraform.tfvars
fi

while read -r line; do
    echo "$line" | tee -a terraform.tfvars
done < terraform.tfvars.tmpl

echo -e "ip_address_list = [\n$IPADDRESS_LIST\n]" | tee -a terraform.tfvars


