#!/bin/bash

SCREEN_MODE=$(</home/radxa/scripts/screen-mode)

RUNNING=0
STREAMING=0

OSD_OPTIONS="--osd --osd-elements video,wfbng"

gpio_chip="gpiochip4"
gpio_offset="10"

cd /home/radxa/Videos

export DISPLAY=:0

while true; do
    if [ $(gpioget $gpio_chip $gpio_offset) -eq 0 ]; then

        if [ $RUNNING -eq 0 ]; then
            kill -15 $STREAMING
            sleep 0.1
            current_date=$(date +'%m-%d-%Y_%H-%M-%S')

                fpvue $OSD_OPTIONS --screen-mode $SCREEN_MODE --dvr-framerate 60 --dvr-fmp4 --dvr record_${current_date}.mp4 &

                RUNNING=$!
        else
                kill -15 $RUNNING
                RUNNING=0
                STREAMING=0
        fi
        sleep 0.1
    elif [ $STREAMING -eq 0 ]; then

        fpvue $OSD_OPTIONS --screen-mode $SCREEN_MODE &

        STREAMING=$!

    fi
    sleep 0.2
done