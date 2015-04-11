
function test-dd-init {
	# Parameters
	# $@	: list of devices to run this test on
	
	# Config
	BLOCK_SIZE="128K"
	BLOCK_COUNT="3200"
	BLOCK_SOURCE="/dev/zero"
	BLOCK_DEST="zeros"
	BLOCK_DATA="$((${BLOCK_SIZE::-1}*$BLOCK_COUNT))${BLOCK_SIZE: -1}"
	
	echo "Running DD test"
	echo "- Block Size: $BLOCK_SIZE"
	echo "- Block Count: $BLOCK_COUNT"
	echo "- Block Source: $BLOCK_SOURCE"
	echo "- Data Total: $BLOCK_DATA"
	
}

function test-dd-write {
	# Init
	test-dd-init

        # Setup logging
        LOG_DIR="$LOG_BASE_DIR/dd/write"
	mkdir -p "$LOG_DIR"
	
        for device in "$@"; do
                # Get the devices name
                device_name=$(basename "$device")

                # Get the devices mountpoint
                device_mountpoint=$(device-mountpoint "$device")

		# Set the log file
		LOG_FILE="$LOG_DIR/$device_name"
		
                # Run DD write
		dd bs=$BLOCK_SIZE if=$BLOCK_SOURCE count=$BLOCK_COUNT 2> /dev/null | pv -pabeWcN "$device" -s "$BLOCK_DATA" | dd bs=$BLOCK_SIZE of=$device_mountpoint/$BLOCK_DEST conv=fdatasync &> "$LOG_FILE" &
                
        done
	
	wait
	echo "TESTS COMPLETE"

}

function test-dd-read {
	# Init
	test-dd-init
	
        # Setup logging
        LOG_DIR="$LOG_BASE_DIR/dd/read"
	mkdir -p "$LOG_DIR"
	
	# Write a test file to each of the devices to read from
	echo "Writing test files..."
	for device in "$@"; do
                # Get the devices mountpoint
                device_mountpoint=$(device-mountpoint "$device")
		
		# Write the file
		dd bs=$BLOCK_SIZE if=$BLOCK_SOURCE of=$device_mountpoint/$BLOCK_DEST count=$BLOCK_COUNT &> /dev/null  &
	done
	
	# Wait for all the test files to be written before continuing...
	wait
	
	for device in "$@"; do
                # Get the devices name
                device_name=$(basename "$device")

                # Get the devices mountpoint
                device_mountpoint=$(device-mountpoint "$device")

                # Set the log file
                LOG_FILE="$LOG_DIR/$device_name"
                
                # Run DD write
                echo "$device: DD read test started"
                dd bs=$BLOCK_SIZE of=/dev/null if=$device_mountpoint/$BLOCK_DEST count=$BLOCK_COUNT &> "$LOG_FILE" &
        done
}
