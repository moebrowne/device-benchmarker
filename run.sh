#!/bin/bash

. /home/pi/benchmark/libs/mount-devices.sh

DEVICE_NAME=$1

# Mount the devices
mount-devices

# Clear caches and buffers
sync && sync
echo 3 > /proc/sys/vm/drop_caches

echo "DD: 1M Blocks | 512 Blocks | 512MB"
dd bs=1M if=/dev/zero of=/media/$DEVICE_NAME/zeros count=512

