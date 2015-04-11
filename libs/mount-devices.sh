

#Mount the USB drives
function mount-devices {
	mount -t ext4 -o defaults /dev/sda1 /media/black
	mount -t ext4 -o defaults /dev/sdb1 /media/orange
}
