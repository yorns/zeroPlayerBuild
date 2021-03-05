DESCRIPTION = "zero player audio server"
LICENSE = "CLOSED"
# LIC_FILES_CHKSUM = "file://LICENSE;md5=254d223b9e70204fcb33cd46be4df2d7"

SRCBRANCH = "master"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI = "git://github.com/yorns/audioServer.git;protocol=https;branch=${SRCBRANCH} \
           file://audioServer.service \
           file://startAudioServer \
          "

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

DEPENDS = "boost snc openssl taglib nlohmann-json gstreamer1.0 ca-certificates spirfid"
RDEPENDS_${PN} = "snc hostapd wpa-supplicant alsa-state alsa-utils gstreamer1.0 \
                  gstreamer1.0-plugins-base gstreamer1.0-meta-base gstreamer1.0-plugins-good \
                  gstreamer1.0-plugins-bad iw ca-certificates wifi-distributor"

inherit cmake
inherit systemd

SYSTEMD_SERVICE_${PN} = "audioServer.service"

do_install_append() {
  install -d ${D}${systemd_unitdir}/system
  install -m 0644 ${WORKDIR}/*.service ${D}${systemd_unitdir}/system
  install -d ${D}${bindir}
  install -m 0755 ${WORKDIR}/startAudioServer ${D}${bindir} 
}

FILES_${PN} = "\
${localstatedir}/audioserver \
${localstatedir}/audioserver/audioMp3 \
${localstatedir}/audioserver/audioJson \
${localstatedir}/audioserver/html \
${localstatedir}/audioserver/cache \
${localstatedir}/audioserver/html/img \
${localstatedir}/audioserver/html/index.html \
${localstatedir}/audioserver/html/font \
${localstatedir}/audioserver/html/font/fontello.eot \
${localstatedir}/audioserver/html/font/fontfontello.svg \
${localstatedir}/audioserver/html/font/fontfontello.ttf \
${localstatedir}/audioserver/html/font/fontfontello.woff \ 
${localstatedir}/audioserver/html/font/fontfontello.woff2 \
${localstatedir}/audioserver/html/css \
${localstatedir}/audioserver/html/css/bootstrap.min.css \
${localstatedir}/audioserver/html/css/fontello.css \
${localstatedir}/audioserver/html/js \
${localstatedir}/audioserver/html/css \
${localstatedir}/audioserver/html/js/bootstrap.min.js \
${localstatedir}/audioserver/html/js/popper.min.js \
${localstatedir}/audioserver/html/js/jquery-3.4.1.min.js \
${localstatedir}/audioserver/html/js/audioserver.js \
${localstatedir}/audioserver/playlistM3u \
${localstatedir}/audioserver/playlistJson \
${sysconfdir}/audioserver.json \
${bindir}/audioServer \
${bindir}/startAudioServer \
"
