
function cache-clear {
	sync && sync
	echo 3 > /proc/sys/vm/drop_caches
}