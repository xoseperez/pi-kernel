## Raspberry Pi Kernel Builder 

Building scripts based on work by Jeff Geerling: https://github.com/geerlingguy/raspberry-pi-pcie-devices/tree/master/extras/cross-compile.

This environment can be used to [cross-compile the Raspberry Pi OS kernel](https://www.raspberrypi.org/documentation/linux/kernel/building.md) from a Linux, Windows, or Mac workstation using Docker.

This build configuration has only been tested with the Raspberry Pi 4 and CM4 and run on Linux.

## Bringing up the build environment

  1. Make sure Docker is installed.
  1. Build and run the docker image we will use for compilation: `./builder`

You will be dropped into a shell inside the container's `/build` directory with only the `make` script.. From here you can work on compiling the kernel.

> After you `exit` out of that shell, the Docker container will stop, but will not be removed. If you want to jump back into it, you can run `docker start cross-compile` and `docker attach cross-compile`.

> Also, the output of the built process will be available under `.build` folder.

## Compiling the Kernel

1. Clone the linux repo (or clone a fork or a different branch), this also resets it if a previous build already exists:

     ```
     ./make init
     ```

  1. Run the following command to add modules to the source:

     ```
     ./make add <path to the module> <destination path>
     ```

     For instance:

     ```
     ./make add extra/sound/soc/tas2505 sound/soc
     ```

  1. Run the following command to make a default .config file:

     ```
     ./make default
     ```

  1. (Optionally) Either edit the .config file by hand or use menuconfig:

     ```
     ./make config
     ```

  1. Compile the Kernel:

     ```
     ./make build
     ```

  1. Create a ZIP file with the kernel image and modules:

     ```
     ./make zip
     ```

> By default, the script creates a `arm64` image. For 32-bit Pi OS set the `ARCH` environment variable before running any command or after running the `init` command to reset the built:

```
export ARCH=arm
```

> The number of cores used to build the image is set to the max by default. If you don't want it to use all the available cores you can set the CORES variable inside the docker container this way:

```
export CORES=1
```



