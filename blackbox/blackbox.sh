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
    echo "Start recording file $CURRENT_FILE at $(date +"%Y-%m-%d-%H:%M:%S") for $RECORD_LENGTH seconds" | tee $CURRENT_DIR/record.log

    # Actually record
    ffmpeg -f alsa -ac 2 -ar $SAMPLE_RATE -i hw:0 -ab $BITRATE -acodec libmp3lame -t $RECORD_LENGTH $CURRENT_DIR/$CURRENT_FILE

    echo "Stop recording file $CURRENT_FILE at $(date +"%Y-%m-%d-%H:%M:%S")" | tee $CURRENT_DIR/record.log
}

echo "SCRIPT STARTING"

# Infinite loop
while :
do
    NEXT_HOUR=$(( $(date +%s -d "$(date +%H -d 'hour'):00") - $(date +%s) ))
    record $NEXT_HOUR
done

echo "SCRIPT EXITED"