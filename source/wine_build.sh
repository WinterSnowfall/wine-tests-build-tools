#!/bin/bash

if [ $# -ge 2 ]
then
    SOURCE_PATH="$PWD"
    git clone https://github.com/wine-mirror/wine.git

    if [ -d wine/dlls/$1 ]
    then
        cd wine
        
        if [ $2 -eq 64 ]
        then
            BUILD_DIR="x86_64-windows"
            ./configure --enable-win64
        else
            BUILD_DIR="i386-windows"
            # enough for a minimal tests build on x86-64 multilib
            ./configure --without-freetype
        fi

        if [ -d dlls/$1/tests ]
        then
            cd dlls/$1/tests
            # will fail post-compilation, during test run,
            # since it won't find a wineserver binary
            make test 2>/dev/null
            
            rm -rf $SOURCE_PATH/../output/$1_test_x$2.exe 2>/dev/null
            cp $BUILD_DIR/$1_test.exe $SOURCE_PATH/../output/$1_test_x$2.exe

            cd $SOURCE_PATH/wine
            make clean
            cd -

            cd $SOURCE_PATH
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

