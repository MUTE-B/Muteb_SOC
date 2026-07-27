#!/bin/bash

#
# ==========================================================
# MUTEB SOC v1.1
# Kernel Hardening Toolkit
# ==========================================================
#

echo "======================================"
echo " MUTEB SOC KERNEL HARDENING"
echo "======================================"



if [[ $EUID -ne 0 ]]; then

echo "[ERROR] Run as root"

exit 1

fi



SYSCTL_FILE="/etc/sysctl.d/99-muteb-soc-hardening.conf"



cat > $SYSCTL_FILE << SYSCTL

# Disable IP Forwarding
net.ipv4.ip_forward = 0


# Enable SYN Cookies
net.ipv4.tcp_syncookies = 1


# Ignore ICMP Redirects
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0


# Disable Source Routing
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0


# Ignore Broadcast Requests
net.ipv4.icmp_echo_ignore_broadcasts = 1


# Enable Reverse Path Filtering
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1


SYSCTL



sysctl --system



echo

echo "[+] Kernel Hardening Completed"

echo "[+] Configuration:"
echo $SYSCTL_FILE

