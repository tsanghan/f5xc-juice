#!/usr/bin/env bash
IMAGE=docker.io/bkimminich/juice-shop
TAG=v20.2.0

printf "%s\n\n" "services:" | tee /tmp/podman-compose.yaml
for port in {1..16}; do
    cat <<-EOF | tee -a /tmp/podman-compose.yaml
  juice-shop-$port:
    image: $IMAGE:$TAG
    container_name: juice-shop-$port
    ports:
      - "$((3000 + port)):3000"

EOF
done

machinectl shell ubuntu@.host systemctl --user enable podman.socket
machinectl shell ubuntu@.host systemctl --user start podman.socket
sudo -u ubuntu bash -l -c "podman compose -f /tmp/podman-compose.yaml up -d"

# podman run -d -p "$((3000 + port))":3000 docker.io/bkimminich/juice-shop:v17.3.0