#!/bin/sh

DIR="$HOME/Pictures/wallpapers"

mkdir -p ${DIR}
# curl -s "https://picsum.photos/1920/1080" -o "${DIR}/$(uuidgen).png"
# RANDOM_IMAGE=$(find ${DIR} -type f | shuf -n 1)
RANDOM_IMAGE="${DIR}/neon-lights.jpg"

# swww img ${RANDOM_IMAGE} --transition-type random

swww img ${RANDOM_IMAGE} --transition-type random
