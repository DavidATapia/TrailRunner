#!/bin/sh

set -x 

showusage() {

>&2 cat << SHOWUSAGE
    usage:
        -h this help message
        -r rebuild Docker image
SHOWUSAGE

    exit 1;
}

FULL_IMAGE_REBUILD=0
while getopts "hr" optval; do
    case "${optval}" in
        h)
            showusage
            ;;
        r)
            FULL_IMAGE_REBUILD=1
            ;;
    esac
done

export NPROC=$(($(nproc) - 3)) # container will share all but two CPUs from host

if [ "$FULL_IMAGE_REBUILD" -eq "1" ] ; then
    export UID=$(id -u); docker compose up --detach --build
elif [ "$FULL_IMAGE_REBUILD" -eq "0" ] ; then
    export UID=$(id -u); docker compose up --detach
fi
