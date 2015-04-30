
Potential features/improvements:

- Check a device has enough space to receive the test file before writing, probably using `df`
- If there isn't enough room on the device offer to empty/format it
- If a device fails to mount throw an error and exit
- Implement a 'full disk' feature where instead of writing/reading so many bytes just the whole disk
- Write all output to a log file
- Add a progress bar when writing test files in test-dd-read

Tests

- cp: Just a straight copy, using either a large number of small files for a small number of large files
