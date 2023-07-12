#!/usr/bin/env bash
count=0
format_disconnected=" OFF"
format_wireless_connected=""
format_ethernet_connected="LAN"

while true; do
	SSID="$(iwgetid -r)"
	ID="$(ip link | awk '/state UP/ {print $2}')"

	if (ping -c 1 archlinux.org || ping -c 1 google.com || ping -c 1 github.com) &>/dev/null; then
		if [[ $ID == e* ]]; then
			echo "$format_ethernet_connected"; sleep 25
		else
			echo "$format_wireless_connected $SSID"; sleep 25
		fi
	else
		echo "$format_disconnected"; sleep 1
	fi
done
