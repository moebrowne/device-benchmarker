#!/bin/bash

# Get the source directory
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

# Set the library root path
LIBRARY_PATH_ROOT="$DIR/libs"
TEST_PATH_ROOT="$DIR/tests"

# Libraries
. "$LIBRARY_PATH_ROOT/cache.sh"
. "$LIBRARY_PATH_ROOT/devices.sh"
. "$TEST_PATH_ROOT/dd.sh"

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
