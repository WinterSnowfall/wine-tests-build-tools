#!/bin/bash

docker rmi wine-builder:latest > /dev/null 2>&1
docker pull archlinux:latest

cd dockerfile
docker build -t wine-builder:latest .
cd ..

