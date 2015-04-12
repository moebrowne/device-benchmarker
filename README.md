# Device Speed Benchmarker

Using this tool you can benchmark the maximum read write speeds connected block devices are capable of either on their own or in parallel with other devices.

## Usage

The bench marker is called using this format:

    ./run.sh {test-name} /dev/device1 /dev/device2 /dev/deviceN

You must be root to run the benchmark as it requires the use of `mount`.

## Tests

The following tests are currently available:

### DD

#### dd-write

Uses dd to write a number of bytes from /dev/zero to all specified devices

#### dd-read

Uses dd to first write a test file to all specified devices then read the file(s) back to `/dev/null`

## Dependencies

There is only a single package required which is non-standard; pv. It's easily installed whatever Distro you are using:

    # Ubuntu
    apt-get install pv
    
    # RHEL / CentOS
    yum install pv

## Warning

This tool will indiscriminately write to the devices specified, double check you are using the correct devices!
