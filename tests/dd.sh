
function test-dd {
	# Parameters
	# $@	: list of devices to run this test on
	
	# Config
	BLOCK_SIZE="1M"
	BLOCK_COUNT="512"
	BLOCK_SOURCE="/dev/zero"
	BLOCK_DEST="zeros"
	
	for device in "$@"; do
		# Get the devices name
		device_name=$(basename "$device")
		
		# Get the devices mountpoint
		device_mountpoint=$(device-mountpoint "$device")
		
		# Set the log file
		LOG_FILE="$LOG_BASE_DIR/$device_name"
		
		# Run DD
		echo "Running DD on $device: Block Size: $BLOCK_SIZE | Count: $BLOCK_COUNT | Source: $BLOCK_SOURCE | Dest: $device_mountpoint/$BLOCK_DEST"
		dd bs=$BLOCK_SIZE if=$BLOCK_SOURCE of=$device_mountpoint/$BLOCK_DEST count=$BLOCK_COUNT &> "$LOG_FILE" &
	done
}
