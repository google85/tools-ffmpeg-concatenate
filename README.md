# ffmpeg-concatenate
bash that uses ffmpeg to concatenate mp4 files from folder into one


### Requirements:
- ffmpeg
$ yum install ffmpeg


### Usage:
$ ./concatenate [--files|--version|-V]


# show version
$ ./concatenate -V

# show files that are to be used
$ ./concatenate --files

# actual concatenate of all MP4 files from current folder or specified, orderer by name
$ ./conatenate


### Example:
$ ./concatenate.sh --folder ./input/ --outfile ./output/file.mp4