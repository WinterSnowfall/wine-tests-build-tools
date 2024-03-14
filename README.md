# wine-test-build-tools

A collection of scripts and tools for constructing a docker image to build Wine tests on a library of choice. Note that `wine-test-build-tools` doesn't actually provide the dependencies required for a full Wine build.

## What do I need?

Docker and dependencies (containerd, runc etc.), in whatever form it comes with your distro. As a note, on Debian and friends the docker package is very intuitively called `docker.io`.

## How do I use this thing?

* After installing docker you'll need to add your user to the docker group.
  
    `sudo usermod -aG docker <your_username>`
  
    Will do the trick, afterwards you'll need a restart of the docker demon (or your system).

* Secondly, you need to make sure all the .sh scripts have their execute permissions set, otherwise nothing will work. Note that execute permissions also need to be added to the script that's part of the `source` folder.

* Now you're set to fetch the latest Arch docker image and construct your build containers. To do that simply run:
  
    `./docker_build.sh`

* Now, to launch your Wine test build, use:
  
    `./wine_build_runner.sh <lib_name> <x86_bits>`
  
    Where `<lib_name>` can be any Wine library that has a dedicated folder under the `dlls` source directory. You can optionally also specify a `<x86_bits>` of `32`, otherwise it will default to `64`.
  
    After the script completes and compilation is successful you can find the test binaries in the `output` folder.

## What about extending it, so it can actually build Wine?

Yeah, no. There are plenty of other tools for doing that. `wine-test-build-tools` is a humble test builder with focus and dedication.

