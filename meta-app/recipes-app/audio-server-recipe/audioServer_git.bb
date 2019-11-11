DESCRIPTION = "zero player audio server"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=254d223b9e70204fcb33cd46be4df2d7"

SRC_URI = "git://github.com/yorns/audioServer.git;protocol=https"

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "${AUTOREV}"
AS_BASEDIR = "/usr/share/audioServer"

S = "${WORKDIR}/git"

DEPENDS = "boost openssl taglib nlohmann-json"
RDEPENDS_${PN} = "wpa-supplicant mplayer-common"

inherit cmake
inherit systemd

SYSTEMD_SERVICE_${PN} = "audioServer.service"

do_install_append() {
  install -d ${AS_BASEDIR}/mp3
  install -d ${AS_BASEDIR}/img
  install -d ${AS_BASEDIR}/tmp
  install -d ${AS_BASEDIR}/playlist
  install -d ${D}${systemd_unitdir}/system
  install -m 0644 ${S}/systemd/audioServer.service ${D}${systemd_unitdir}/system
  install -m 0644 ${S}/html/index.html ${AS_BASEDIR}
}
