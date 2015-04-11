# Device Speed Benchmarker

This tool is intended to benchmark the maximum read write speed of one or more connected devices

## Usage

The benchmarker is ./run.sh it takes the following parameters:

    ./run.sh TEST_TO_BE_RUN /dev/device1 /dev/device2 /dev/deviceN

You must be root to run the benchmark as it requires the use of `mount`

## Tests

The following tests are avaliable:

### DD

Uses dd to copy a number of bytes from /dev/zero to the specified devices

