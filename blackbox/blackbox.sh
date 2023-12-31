#!/bin/sh

# File settings
CHUNK_LENGTH=1800
SAVE_DIR=/home/puretech/record/

# Audio settings
SAMPLE_RATE=44100
BITRATE=96k

# Infinite loop
while :
do
    # Make the folder for this chunk if it doesn't exist
    CURRENT_DIR=$SAVE_DIR/$(date +"%Y/%m/%d")
    mkdir -p $CURRENT_DIR

    # Actually record
    ffmpeg -f alsa -ac 2 -ar $SAMPLE_RATE -i hw:0 -ab $BITRATE -acodec libmp3lame -t $CHUNK_LENGTH $CURRENT_DIR/$(date +"%H-%M-%S").mp3
done
