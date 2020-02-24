# Readme

This yocto-based buildsystem uses a Docker container for the build of a Raspberry Pi image.
The Dockerfile is located in `https://github.com/crops/poky-container` and is based on ubuntu 18.04
The Docker image contains all tools to build with the OpenEmbedded/Yocto buildsystem. 
The buildsystem uses the Google repo tool (https://android.googlesource.com/tools/repo) to setup the 
Yocto layer structure (i.e. checkout all repos).

# Usage (bash)

Build the Docker image:
```
cd docker
export WORKDIR=$USER/tmp/workdir/
mkdir -p $WORKDIR
docker run --rm -it -v $WORKDIR:/workdir crops/poky --workdir=/workdir
```

Start a yocto build based on zeus branch 
(inside the running Docker container or on a host which has all required build host packages installed:
https://www.yoctoproject.org/docs/current/yocto-project-qs/yocto-project-qs.html#packages):
```
repo init -u https://github.com/yorns/zeroPlayerBuild.git -b zeus
repo sync
. setup-environment
bitbake zero-image
```

The final images are stored in $USER/tmp/workdir/build/tmp/deploy/images/raspberry0-wifi

