#!/bin/bash

OUTPUT_PATH="$PWD/output"
SOURCE_PATH="$PWD/source"
# update if you care about file timestamps
TIMEZONE=Etc/UTC

if [ $# -ge 1 ]
then
    if [ $# -ge 2 ]
    then
        if [ $2 -eq 32 -o $2 -eq 64 ]
        then
            BUILD_X86_BITS=$2
        else
            echo "Invalid parameters: unsupported x86 bit value of $2!"
            exit 2
        fi
    else
        # build 64-bit tests by default,
        # change to 32 to build for i686
        BUILD_X86_BITS=64
    fi

    docker run -ti --rm \
               --name wine-builder \
               -h wine-builder \
               -e TZ="$TIMEZONE" \
               -e TEST_LIB=$1 \
               -e BUILD_X86_BITS=$BUILD_X86_BITS \
               -v $SOURCE_PATH:/home/builder/source \
               -v $OUTPUT_PATH:/home/builder/output \
               wine-builder
else
    echo "Invalid parameters: please specify the target lib!"
    exit 1
fi

