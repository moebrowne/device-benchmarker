#!/bin/bash

# Librarys
. /home/pi/benchmark/libs/devices.sh
. /home/pi/benchmark/tests/dd.sh

# Parameters
# $1		: Type of test to run
# ${N+1}	: Devices to run the test on

# Define variables
TEST="$1"
DEVICES="${@: 2}"
TIMESTAMP="$(date +"%s")"
LOG_BASE_DIR="/home/pi/benchmark/logs/$TIMESTAMP" 

# Create the logging directory
mkdir -p "$LOG_BASE_DIR"

echo "Logs will be written to: $LOG_BASE_DIR"

# Mount all the devices
for device in $DEVICES; do
	device-mount "$device"
done

# Clear caches and buffers
echo "Clearning caches and buffers"
sync && sync
echo 3 > /proc/sys/vm/drop_caches

if [ "$TEST" == "dd" ]; then
	test-dd $DEVICES
fi
