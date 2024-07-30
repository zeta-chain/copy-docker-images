#!/bin/bash

set -eo pipefail

target_registry=$1

source_images=(
    # localnet test images
    "ruimarinho/bitcoin-core:22"
    "ethereum/client-go:v1.10.26"

    # localnet build images
    "golang:1.22.5-bookworm"

    # docker syntax
    docker/dockerfile:1.7-labs
)

for source_image in "${source_images[@]}"; do
    # replaces slashes in images names with dashes
    target_image_name=$(echo "${source_image}" | tr '/' '-')
    crane copy "${source_image}" "${target_registry}/${target_image_name}"
done