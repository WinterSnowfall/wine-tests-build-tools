#!/bin/bash

docker rmi wine-test-builder:latest 2>/dev/null
docker pull archlinux:latest

cd dockerfile
docker build -t wine-test-builder:latest .
cd ..

