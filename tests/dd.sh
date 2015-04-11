
function test-dd-init {
	# Parameters
	# $@	: list of devices to run this test on
	
	# Config
	BLOCK_SIZE="1M"
	BLOCK_COUNT="512"
	BLOCK_SOURCE="/dev/zero"
	BLOCK_DEST="zeros"
	
	echo "Running DD test"
	echo "- Block Size: $BLOCK_SIZE"
	echo "- Block Count: $BLOCK_COUNT"
	echo "- Block Source: $BLOCK_SOURCE"
	
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
                echo "$device: DD write test started"
                dd bs=$BLOCK_SIZE if=$BLOCK_SOURCE of=$device_mountpoint/$BLOCK_DEST count=$BLOCK_COUNT &> "$LOG_FILE" &
        done

}

function test-dd-read {
	# Init
	test-dd-init
	
        # Setup logging
        LOG_DIR="$LOG_BASE_DIR/dd/read"
	mkdir -p "$LOG_DIR"
	
	# Write a test file to each of the devices to read from
	for device in "$@"; do
                # Get the devices mountpoint
                device_mountpoint=$(device-mountpoint "$device")
		
		echo "$device: Writing test file to read from"
		
		# Write the file
		dd bs=$BLOCK_SIZE if=$BLOCK_SOURCE of=$device_mountpoint/$BLOCK_DEST count=$BLOCK_COUNT &> /dev/null
	done
	
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
