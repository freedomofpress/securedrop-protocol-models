#!/bin/sh
set -eux

MAUDE_VERSION="${MAUDE_VERSION:-3.5}"
TAMARIN_VERSION="${TAMARIN_VERSION:-1.12.0}"

export DEBIAN_FRONTEND=noninteractive

# Runtime dependencies:
apt-get update
apt-get install --no-install-recommends --yes \
    ca-certificates \
    curl \
    graphviz \
    make \
    libffi8 \
    libgmp10 \
    libstdc++6 \
    libtinfo6 \
    python3 \
    unzip \
    zlib1g
rm -rf /var/lib/apt/lists/*

# Maude:
curl -fsSL -o /tmp/maude.zip \
    "https://github.com/maude-lang/Maude/releases/download/Maude${MAUDE_VERSION}/Maude-${MAUDE_VERSION}-linux-x86_64.zip"
mkdir -p /opt/maude
unzip -j -o /tmp/maude.zip -d /opt/maude
rm -f /tmp/maude.zip
chmod 0755 /opt/maude/maude
ln -sf /opt/maude/maude /usr/local/bin/maude

# Tamarin:
curl -fsSL -o /tmp/tamarin.tar.gz \
    "https://github.com/tamarin-prover/tamarin-prover/releases/download/${TAMARIN_VERSION}/tamarin-prover-${TAMARIN_VERSION}-linux64-ubuntu.tar.gz"
mkdir -p /tmp/tamarin
tar -xzf /tmp/tamarin.tar.gz -C /tmp/tamarin
install -m 0755 \
    "$(find /tmp/tamarin -type f -name tamarin-prover | head -n1)" \
    /usr/local/bin/tamarin-prover
rm -rf /tmp/tamarin /tmp/tamarin.tar.gz
