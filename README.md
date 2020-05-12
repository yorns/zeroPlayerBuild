# Zeroplayer

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
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
repo init -u https://github.com/yorns/zeroPlayerBuild.git 
repo sync
. setup-environment
bitbake zero-image
```

The final images are stored on the host (please set WORKDIR in that environment if necessary)
in $WORKDIR/build/tmp/deploy/images/raspberrypi0-wifi/zero-image-raspberrypi0-wifi.rpi-sdimg

# Changing between wifi client and server mode

## Wifi Client Mode
On the main branch, the system is set up in wifi client mode. Advantage is, that the small device links into your local wifi.
Disadvantage is, that you need to set up your wifi credentials on your image.

To do so, replugin your sd card to let the system load the sd file system. On this file system, open the file /etc/wpa\_supplicant.conf and set your personal wifi credentials (Wifi Network Name and Password).

example:
```vim /media/yorn/c55aa1af-330a-466a-a747-ff1d60730f49/etc/wpa_supplicant.conf```

then you see this:
```
ctrl_interface=/var/run/wpa_supplicant
ctrl_interface_group=0
update_config=1

network={
        ssid="Wifi-SSID-Here"
        psk="wpa-ascii-passphrase-here"
        proto=RSN
        key_mgmt=WPA-PSK
        pairwise=CCMP
        auth_alg=OPEN
}
```

Change your Accesspoint **ssid** (access point name) and the password **psk** according to your credentials. In case you do not have WPA2 encryption, please find the correct parameters with an internet search :).  

internally the building branch for this is **wifi_client**. This branch is taken automatically, if you setup the system on docker. So use the master branch for your docker setup and repo will be choosen corretly.

## Wifi Accesspoint Mode
Your can also setup your raspberry pi to open your own Accesspoint (without a password). In this case, there is another branch **with_hostapd** you can use.
 

