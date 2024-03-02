#!/bin/bash

docker rmi wine-test-builder:latest > /dev/null 2>&1
docker pull archlinux:latest

cd dockerfile
docker build -t wine-test-builder:latest .
cd ..

