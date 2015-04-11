#!/bin/bash

# Libraries
. /home/pi/benchmark/libs/cache.sh
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
cache-clear

if [ "$TEST" == "dd-read" ]; then
	test-dd-read $DEVICES
fi

if [ "$TEST" == "dd-write" ]; then
	test-dd-write $DEVICES
fi
