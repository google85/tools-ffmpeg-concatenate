#!/bin/bash

################################################################################
#                                                                              #
#  Don't forget to make this file executable                                   #
#  (chmod +x ./concatenate.sh )                                                #
#                                                                              #
# - concatenates all .MP4 files in the current (or specified) folder into one  #
#                                                                              #
#                                                                              #
# (c) 2022 .:DjBpF:.                                                           #
#                                                                              #
################################################################################

# set vars
FFMPEG_PATH=ffmpeg
INFOLDER=.
FILES_TYPE='*.MP4'
OUTPUT_FILE="output.mp4"
EXECUTABLE=concatenate.sh
VERSION=1.0.0
SHOW_FILES=0
STOP_BEFORE_CONCAT=0        # with --files will abort concatenation (show only)

# get passed params
POSITIONAL=()
while [[ $# -gt 0 ]]
do
options="$1"

show_logo() {
    echo -e "concatenate v.$VERSION"
    echo -e "----------------------"
}

case $options in
    -v|-V|--version)
    echo -e " \n"
    show_logo
    echo -e "Copyright (c) 2021 .:DjBpF:. \n"
    echo -e For a list of options type concatenate -h '\n'
    exit 0
    shift # past argument
    shift # past value
    ;;

    -h|--help)
    echo -e ' \n'
    show_logo
    echo -e "Usage: concatenate [-h] [-v] [--files] [--folder FOLDER_NAME] \n"
    echo -e "Options: \r"
    echo -e " \t  -h, --help                 display this help"
    echo -e " \t  -v, --version              show version"
    echo -e " \t      --folder FOLDER_NAME   sets the folder where the files are found"
    echo -e " \t      --files                show files that will be included in the concatenation."
    echo -e "Examples: \r"
    echo -e "sh $EXECUTABLE --help"
    echo -e "sh $EXECUTABLE --files"
    echo -e "sh $EXECUTABLE --folder test"
    echo -e "sh $EXECUTABLE --folder test --files"
    exit 0
    shift # past argument
    shift # past value
    ;;

    --files)
    SHOW_FILES=1
    echo -e " \n"
    show_logo
    #echo -e ' \n'
    #shift # past argument
    shift # past value
    ;;

    --folder)
    INFOLDER="$2"
    echo -e "Folder set: $INFOLDER"
    shift # past argument
    #shift # past value - nu am value
    shift
    ;;

    -outfile|--outfile)
    OUTPUT_FILE="$2"
    shift # past argument
    shift # past value
    ;;
    *)
#    INFOLDER="$2" # ce a ramas
    shift
    #shift # past argument
    shift # past value
    ;;
    
    --default)
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

##echo SHOW_FILES=$SHOW_FILES

# if it's not a valid folder, print message and exit
if [[ ! -d $INFOLDER ]]; then
    echo "${INFOLDER} folder doesn't exists!"
    exit 1
fi

show_files() {
    STOP_BEFORE_CONCAT=1
    echo -e "Files that are about to be used in concatenation:"
    find "$INFOLDER" -name "$FILES_TYPE" -printf "- %p \n" | sort -n
    #return
}

# if
if [ "$SHOW_FILES" -eq "1" ]; then
    echo -e ' \n'
    show_files
fi
#[ "$SHOW_FILES" == "1" ] && { show_files(); }

if [ "$STOP_BEFORE_CONCAT" -ne "1" ]; then
    echo -e "\n"
    echo -e "Concatenating files..."
    # next line gives error if not chmod-ex +x
	# optional
#	find "$INFOLDER" -name "$FILES_TYPE" -printf "file '$PWD/%p'\n" | sort -n > list.lst
    $FFMPEG_PATH -f concat -safe 0 -i <(find . -name '*.MP4' -printf "file '$PWD/%p'\n" | sort -n) -c copy $OUTPUT_FILE
    echo -e "Done. \n"
fi

##echo infolder=$INFOLDER


exit 0