# ffmpeg-concatenate
bash that uses ffmpeg to concatenate mp4 files from folder into one


### Requirements:
- ffmpeg
```bash
 yum install ffmpeg
```


### Usage:
```bash
 ./concatenate [--files|--version|-V]
```


#### - show version
```bash
 ./concatenate -V
```

#### - show files that are to be used
```bash
 ./concatenate --files
```

#### - actual concatenate of all MP4 files from current folder or specified, orderer by name
```bash
 ./conatenate
```


### Example:
```bash
 ./concatenate.sh --folder ./input/ --outfile ./output/file.mp4
```