# Readme

This yocto-based buildsystem uses a Docker container for the build of a Raspberry Pi zero-w image.
The Dockerfile is located in folder `docker` and based on `crop porky ubuntu-18.04` (https://github.com/crops/poky-container).
The Docker image contains all tools to build with the OpenEmbedded/Yocto buildsystem. The workspace is created in a volume 
directory given by the the host.
The buildsystem uses the Google repo tool (https://android.googlesource.com/tools/repo) to setup the Yocto layer structure (i.e. checkout all repos).

# Usage

Build the Docker image:
```
cd docker
export WORKDIR=$HOME/tmp/workdir/
mkdir -p $WORKDIR
docker build . -t crops/poky
docker run --rm -it -v $WORKDIR:/workdir crops/poky --workdir=/workdir
```

Start a yocto build (inside the running Docker container or on a host which has all required build host packages installed:
https://www.yoctoproject.org/docs/current/yocto-project-qs/yocto-project-qs.html#packages):
```
repo init -u https://github.com/yorns/zeroPlayerBuild.git -b zeus
repo sync
. setup-environment
bitbake zero-image
```

The final images are stored on the host (please set WORKDIR in that environment if necessary)
in $WORKDIR/build/tmp/deploy/images/raspberrypi0-wifi/zero-image-raspberrypi0-wifi.rpi-sdimg


