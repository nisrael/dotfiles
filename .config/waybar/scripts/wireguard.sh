#!/bin/bash
if nmcli -t -f GENERAL.STATE con show wg_f1e 2>/dev/null | grep -q activated; then
    iface=$(nmcli -t -f GENERAL.IP-IFACE con show wg_f1e 2>/dev/null | cut -d: -f2)
    endpoint=$(sudo wg show "$iface" endpoints 2>/dev/null | awk '{print $2}')
    latest=$(sudo wg show "$iface" latest-handshakes 2>/dev/null | awk '{print $2}')
    transfer=$(sudo wg show "$iface" transfer 2>/dev/null | awk '{printf "↓ %.1f MiB  ↑ %.1f MiB", $2/1048576, $3/1048576}')
    if [ -n "$latest" ] && [ "$latest" != "0" ]; then
        handshake=$(date -d @"$latest" '+%H:%M:%S')
    else
        handshake='never'
    fi
    tooltip="󰖂  wg_f1e  connected\\n󰩠  ${endpoint}\\n󰁫  ${handshake}\\n󰓅  ${transfer}"
    printf '{"text":"󰖂","tooltip":"%s","class":"connected"}\n' "$tooltip"
else
    printf '{"text":"󰖃","tooltip":"󰖃  wg_f1e  disconnected","class":"disconnected"}\n'
fi
