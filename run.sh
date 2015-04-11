#!/bin/bash

# Librarys
. /home/pi/benchmark/libs/devices.sh

# Parameters
# $1		: Type of test to run
# ${N+1}	: Devices to run the test on

# Define variables
TEST="$1"
DEVICES="${@: 2}"

# Mount all the devices
for device in "$DEVICES"; do
	device-mount "$device"
done

# Clear caches and buffers
echo "Clearning caches and buffers"
sync && sync
echo 3 > /proc/sys/vm/drop_caches



echo "DD: 1M Blocks | 512 Blocks | 512MB"
dd bs=1M if=/dev/zero of=/media/orange/zeros count=512 2> black &
dd bs=1M if=/dev/zero of=/media/black/zeros count=512 2> orange &

