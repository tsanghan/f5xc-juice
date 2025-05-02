#!/usr/bin/env bash

for port in {1001..1016}; do
    docker run -d -p "$port":3000 bkimminich/juice-shop:v17.2.0
done