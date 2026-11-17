#!/usr/bin/env bash
# Download, verify, install, and enter the TD-DFT / NTO lesson.
set -euo pipefail
base='https://raw.githubusercontent.com/Skylark51/dft-tutorial-tddft-nto-wsl/main'
missing=()
command -v python3 >/dev/null || missing+=(python3)
command -v vi >/dev/null || missing+=(vim-tiny)
command -v curl >/dev/null || missing+=(curl)
if ((${#missing[@]})); then
    if [[ $(id -u) == 0 ]]; then
        apt-get update
        apt-get install -y "${missing[@]}"
    else
        sudo apt-get update
        sudo apt-get install -y "${missing[@]}"
    fi
fi
cache="$HOME/.cache/dft-tddft"
mkdir -p -- "$cache"
stage=$(mktemp -d "$cache/start.XXXXXXXX")
trap 'rm -r -- "$stage"' EXIT
curl --fail --silent --show-error --location --retry 3 "$base/install-dft-tddft.sh" -o "$stage/install-dft-tddft.sh"
curl --fail --silent --show-error --location --retry 3 "$base/SHA256SUMS.txt" -o "$stage/SHA256SUMS.txt"
(cd -- "$stage" && sha256sum --check --status SHA256SUMS.txt)
bash "$stage/install-dft-tddft.sh"
