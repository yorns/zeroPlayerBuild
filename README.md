# Readme

This yocto-based buildsystem uses a Docker container for the build of a Raspberry Pi image.
The Dockerfile is located in folder `docker` and based on `crops/poky:ubuntu-16.04` (https://hub.docker.com/r/crops/poky/).
The Docker image contains all tools to build with the OpenEmbedded/Yocto buildsystem. The workspace is created in a mounted folder of the host.
The buildsystem uses the Google repo tool (https://android.googlesource.com/tools/repo) to setup the Yocto layer structure (i.e. checkout all repos).

# Usage

Build the Docker image:
```
cd docker
./manage-build-container.sh build
# Create a volume
docker volume create buildvol
# Run the Docker container
./manage-build-container.sh run
```

Start a yocto build (inside the running Docker container or on a host which has all required build host packages installed:
https://www.yoctoproject.org/docs/current/yocto-project-qs/yocto-project-qs.html#packages):
```
repo init -u https://github.com/yorns/zeroPlayerBuild.git
repo sync
. setup-environment
bitbake rpi-image
```

The final images are stored in  _<build-dir>/tmp/deploy/images/raspberry0-wifi_.
