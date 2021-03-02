# Zeroplayer

This yocto-based buildsystem uses a Docker container for the build of a Raspberry Pi zero-w image.
The Dockerfile is located in folder `docker` and based on `crop porky ubuntu-18.04` (https://github.com/crops/poky-container).
The Docker image contains all tools to build with the OpenEmbedded/Yocto buildsystem. The workspace is created in a volume 
directory given by the the host.

The buildsystem uses the Google repo tool (https://android.googlesource.com/tools/repo) to setup the Yocto layer structure (i.e. checkout all repos).

# Usage

Checkout the right branch (start should be master branch).

```
git clone https://github.com/yorns/zeroPlayerBuild.git
cd zeroPlayerBuild
```

Build the Docker image:
```
cd docker
export WORKDIR=$HOME/tmp/workdir/
mkdir -p $WORKDIR
docker build . -t crops/poky
docker run --rm -it -v $WORKDIR:/workdir crops/poky --workdir=/workdir
```

In case you have set the docker environment, on a second run, you can do:
```
cd docker
export WORKDIR=$HOME/tmp/workdir/
docker run --rm -it -v $WORKDIR:/workdir crops/poky --workdir=/workdir
```



## Start a yocto build
inside the running Docker container or on a host which has all required build host packages installed:
https://www.yoctoproject.org/docs/current/yocto-project-qs/yocto-project-qs.html#packages

```
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
repo init -u https://github.com/yorns/zeroPlayerBuild.git
repo sync
. setup-environment
bitbake zero-image
```

The final images are stored on the host at (please set WORKDIR variable in that environment if necessary)
in $WORKDIR/build/tmp/deploy/images/raspberrypi0-wifi/zero-image-raspberrypi0-wifi.rpi-sdimg

## Writing the image to an sd card
```
sudo su
dd if=/home/yorn/tmp/workdir/build/tmp/deploy/images/raspberrypi0-wifi/zero-image-raspberrypi0-wifi.rpi-sdimg  of=/dev/mmcblk0 bs=1M status=progress
```

## In case you want to reuse the generated blobs (and only update changes), find some hints here 
https://github.com/yorns/zeroPlayerBuild/wiki/Tips-and-Tweaks

