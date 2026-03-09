#!/bin/bash

INTERFACE="enp3s0"
EXTRA_IP="192.168.1.220/24"

# if the IP is already assigned
if ip addr show $INTERFACE | grep -q "${EXTRA_IP%/*}"; then
    echo "already ok"
else
  #otherwise
    sudo ip addr add $EXTRA_IP dev $INTERFACE
    echo "Done."
fi
