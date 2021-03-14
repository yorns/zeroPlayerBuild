DESCRIPTION = "Remote Control Handler"
LICENSE = "CLOSED"
#LIC_FILES_CHKSUM = "file://LICENSE;md5=254d223b9e70204fcb33cd46be4df2d7"

S = "${WORKDIR}"

RDEPENDS_${PN} = "snc iw " 
#DEPENDS = "snc iw "

inherit systemd
SRC_URI += "file://systemd/wifi-distributor.service file://scanWifi.sh"
SYSTEMD_SERVICE_${PN} = "wifi-distributor.service"

do_install_append() {
  install -d ${D}${systemd_unitdir}/system
  install -m 0644 ${S}/systemd/wifi-distributor.service ${D}${systemd_unitdir}/system
  install -d ${D}${bindir}
  install -m 0755 ${S}/scanWifi.sh ${D}${bindir}
}

FILES_{PN} = "${bindir}/scanWifi.sh"

SYSTEMD_AUTO_ENABLE_${PN} = "enable"

