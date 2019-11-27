DESCRIPTION = "zero player audio server"
LICENSE = "CLOSED"
# LIC_FILES_CHKSUM = "file://LICENSE;md5=254d223b9e70204fcb33cd46be4df2d7"

SRC_URI = "git://github.com/yorns/audioServer.git;protocol=https"

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

DEPENDS = "boost openssl taglib nlohmann-json"
RDEPENDS_${PN} = "hostapd mpv"

inherit cmake
inherit systemd

SYSTEMD_SERVICE_${PN} = "audioServer.service"

do_install_append() {
  install -d ${D}${systemd_unitdir}/system
  install -m 0644 ${S}/systemd/audioServer.service ${D}${systemd_unitdir}/system
}

FILES_${PN} = "\
${localstatedir}/audioserver \
${localstatedir}/audioserver/mp3 \
${localstatedir}/audioserver/tmp \
${localstatedir}/audioserver/html \
${localstatedir}/audioserver/html/img \
${localstatedir}/audioserver/html/index.html \
${localstatedir}/audioserver/playlist \
${localstatedir}/audioserver/player_log \
${bindir}/audioServer"

