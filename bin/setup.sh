#!bin/bash

mkdir -p tmp
# install tools concurrently
make -j"$MAKE_SETUP_JOBS" setup
