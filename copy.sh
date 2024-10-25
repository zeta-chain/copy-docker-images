#!/bin/bash

set -eo pipefail

target_registry=$1

source_images=(
    # localnet test images
    "ruimarinho/bitcoin-core:22"
    "ethereum/client-go:v1.10.26"

    # localnet build images
    "golang:1.22.7-bookworm"

    # localnet monitoring images
    grafana/grafana:11.2.0
    prom/prometheus:v2.53.1
    cloudflare/cloudflared:2024.9.1
    grafana/loki:3.1.0
    grafana/promtail:2.9.9

    # docker syntax
    docker/dockerfile:1.9-labs

    # semgrep image
    semgrep/semgrep:1.90.0
)

for source_image in "${source_images[@]}"; do
    # replaces slashes in images names with dashes
    target_image_name=$(echo "${source_image}" | tr '/' '-')
    crane copy "${source_image}" "${target_registry}/${target_image_name}"
done

