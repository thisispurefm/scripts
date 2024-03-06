#!/bin/sh

# File settings
SAVE_DIR=/home/puretech/record/

# Audio settings
SAMPLE_RATE=44100
BITRATE=192k

record()
{
    RECORD_LENGTH=$1

    # Make the folder for this chunk if it doesn't exist
    CURRENT_DIR=$SAVE_DIR/$(date +"%Y/%m/%d")
    mkdir -p $CURRENT_DIR

    CURRENT_FILE=$(date +"%H-%M-%S").mp3
    echo "Start recording file $CURRENT_FILE at $(date +"%Y-%m-%d-%H:%M:%S") for $RECORD_LENGTH seconds" | tee -a $CURRENT_DIR/record.log

    # Actually record
    ffmpeg -f alsa -ac 2 -ar $SAMPLE_RATE -i hw:0 -ab $BITRATE -acodec libmp3lame -t $RECORD_LENGTH $CURRENT_DIR/$CURRENT_FILE

    echo "Stop recording file $CURRENT_FILE at $(date +"%Y-%m-%d-%H:%M:%S")" | tee -a $CURRENT_DIR/record.log
}

echo "SCRIPT STARTING"

echo "Setting volumes"

amixer -c 0 set "Front Mic" 0db
amixer -c 0 set "Front Mic Boost" 0db
amixer -c 0 set "Capture" 0db

# Infinite loop
while :
do
    NEXT_HOUR=$(( $(date +%s -d "$(date +'%Y-%m-%d %H:00:00' -d 'hour')") - $(date +%s) ))
    record $NEXT_HOUR
done

echo "SCRIPT EXITED"
