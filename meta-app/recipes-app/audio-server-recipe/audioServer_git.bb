DESCRIPTION = "zero player audio server"
LICENSE = "CLOSED"
# LIC_FILES_CHKSUM = "file://LICENSE;md5=254d223b9e70204fcb33cd46be4df2d7"

SRC_URI = "git://github.com/yorns/audioServer.git;protocol=https"

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

DEPENDS = "boost openssl taglib nlohmann-json"
RDEPENDS_${PN} = "wpa-supplicant mplayer-common"

inherit cmake
inherit systemd

SYSTEMD_SERVICE_${PN} = "audioServer.service"

do_install_append() {
  install -d ${D}${datadir}/audioserver/mp3
  install -d ${D}${datadir}/audioserver/tmp
  install -d ${D}${datadir}/audioserver/html
  install -d ${D}${datadir}/audioserver/html/img
  install -d ${D}${datadir}/audioserver/playlist
  install -d ${D}${systemd_unitdir}/system
  install -m 0644 ${S}/systemd/audioServer.service ${D}${systemd_unitdir}/system
  install -m 0644 ${S}/html/index.html ${D}${datadir}/audioserver/html
}

FILES_${PN} = "\
${datadir}/audioserver \
${datadir}/audioserver/mp3 \
${datadir}/audioserver/tmp \
${datadir}/audioserver/html \
${datadir}/audioserver/html/img \
${datadir}/audioserver/html/index.html \
${datadir}/audioserver/playlist \
§{bindir}/audioServer
"

