#!/bin/sh

nmcli connection add type wifi ssid "🐰 rabbithole" \
  wifi-sec.key-mgmt wpa-eap \
  802-1x.eap peap \
  802-1x.phase2-auth mschapv2 \
  802-1x.identity "nisrael" \
  802-1x.password "123" \
  802-1x.ca-cert ~/dotfiles/scripts/rabbithole-ca_crt.pem
