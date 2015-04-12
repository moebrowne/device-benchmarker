
function device-mount {
	# Check if the device is already mounted
	if [ $(mount | grep -c "$1") = 1 ]; then
		echo "$1: Already mounted"
		return 
	fi
	
	# Get the device name
	DEVICE_NAME=$(basename "$1")
	
	# Set the mount point directory
	DEVICE_MOUNTPOINT="/media/$DEVICE_NAME"
	
	# Check if a mount directory exists for this device
	if [ ! -d "$DEVICE_MOUNTPOINT" ]; then
		# Create the mount point
		echo "$i: Creating mount point $DEVICE_MOUNTPOINT"
		mkdir -p "$DEVICE_MOUNTPOINT"
	fi
	
	# Mount the device
	echo "$1: Mounting to $DEVICE_MOUNTPOINT"
	mount $1 $DEVICE_MOUNTPOINT
	
}

function device-mountpoint {
	# Get the device name
        DEVICE_NAME=$(basename "$1")

        # Return the mount point directory
        echo "/media/$DEVICE_NAME"
}
