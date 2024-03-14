#!/bin/bash

if [ $# -ge 2 ]
then
    SOURCE_PATH="$PWD"
    TEST_LIB="$1"
    BUILD_X86_BITS=$2

    # speed up things by doing a shallow clone
    git clone --depth 1 https://github.com/wine-mirror/wine.git

    if [ -d "wine/dlls/$TEST_LIB" ]
    then
        cd wine
        
        if [ $BUILD_X86_BITS -eq 64 ]
        then
            BUILD_DIR="x86_64-windows"
            ./configure --enable-win64
        else
            BUILD_DIR="i386-windows"
            # enough for a minimal tests build on x86-64 multilib
            ./configure --without-freetype
        fi

        if [ -d "dlls/$TEST_LIB/tests" ]
        then
            cd "dlls/$TEST_LIB/tests"
            # will fail post-compilation, during test run,
            # since it won't find a wineserver binary
            make test 2>/dev/null
            
            rm -f "$SOURCE_PATH/../output/$TEST_LIB"_test_x$BUILD_X86_BITS.exe 2>/dev/null
            cp "$BUILD_DIR/$TEST_LIB"_test.exe "$SOURCE_PATH/../output/$TEST_LIB"_test_x$BUILD_X86_BITS.exe

            cd "$SOURCE_PATH/wine"
            make clean
            cd ..
            # uncomment if you want to remove the source wine dir
            #rm -rf wine
        else
            echo "Invalid parameters: specified target lib does not contain tests!"
            exit 3
        fi
    else
        echo "Invalid parameters: specified target lib does not exist!"
        exit 2
    fi
else
    echo "Invalid parameters: please specify the target lib and architecture!"
    exit 1
fi

