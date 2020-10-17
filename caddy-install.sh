#!/usr/bin/env bash
set -e
fail () { echo $1 >&2; exit 1; }
[[ $(id -u) = 0 ]] || fail "Please run as root (i.e 'sudo $0')"

export DEBIAN_FRONTEND=noninteractive

sudo apt update

# install caddy
# source: https://caddyserver.com/docs/download#debian-ubuntu-raspbian
if [[ ! -a /etc/apt/sources.list.d/caddy-fury.list ]]; then
  sudo tee -a /etc/apt/sources.list.d/caddy-fury.list <<EOF 
deb [trusted=yes] https://apt.fury.io/caddy/ /
EOF
fi

sudo apt update
sudo apt install -y caddy

echo "Openning ports 80(http)/443(https) in the firewall"
sudo ufw allow 80,443/tcp

cd
caddy reload

echo "If you want to change the Caddyfile, run 'caddy reload' afterwards"
