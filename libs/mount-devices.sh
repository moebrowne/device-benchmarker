

#Mount the USB drives
function mount-devices {
	mount -t ext4 -o defaults /dev/sda1 /media/black
	mount -t ext4 -o defaults /dev/sdb1 /media/orange
}

function mount-device {
	# Check if the device is already mounted
	if [ $(mount | grep -c "$1") != 1 ]; then
		echo "Device $1 is already mounted. Moving on..."
		exit
	fi
	
	# Get the device name
	DEVICE_NAME=$(basename "$1")
	
	# Set the mount point directory
	DEVICE_MOUNTPOINT="/media/$DEVICE_NAME"
	
	# Check if a mount directory exists for this device
	if [ ! -d "$DEVICE_MOUNTPOINT" ]; then
		# Create the mount point
		echo "Creating the mount point directory"
		mkdir -p "$DEVICE_MOUNTPOINT"
	fi
	
	# Mount the device
	echo "Mounting $1 to $DEVICE_MOUNTPOINT"
	mount $1 $DEVICE_MOUNTPOINT
	
}
