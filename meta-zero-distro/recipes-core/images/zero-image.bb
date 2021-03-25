# Distro Layer configuration
# include and overwrite default poky distro
include recipes-core/images/core-image-base.bb

DESCRIPTION = "Custom image based on core-basic-image"

# set standard image to be 3.5 GB
# IMAGE_ROOTFS_SIZE = "3500000"

# We only need a rpi-sdimg image here
IMAGE_FSTYPES_raspberrypi0-wifi ?= "tar.bz2 rpi-sdimg"

IMAGE_FEATURES += "ssh-server-dropbear"

hostname_pn-base-files = "zeroplayer"

# Additional packages
IMAGE_INSTALL_append = " \
  haveged \
  linux-firmware-bcm43430 \
  bash \
  audioserver \
  spirfid \
  "

LICENSE="GPLv3"

export IMAGE_BASENAME = "zero-image"

