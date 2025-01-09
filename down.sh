#!/bin/sh

set -x

export NPROC=$(($(nproc) - 3)) # container will share all but two CPUs from host

export UID=$(id -u); docker compose down
