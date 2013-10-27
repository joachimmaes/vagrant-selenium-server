#!/bin/bash

TARGET_FILE=${1:-/tmp/video.mov}
/home/vagrant/bin/ffmpeg -y -r 30 -s 1024x768 -f x11grab -i :99 -vcodec qtrle $TARGET_FILE
