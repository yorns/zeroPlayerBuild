DESCRIPTION = "Simple Network Communication"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=254d223b9e70204fcb33cd46be4df2d7"

SRC_URI = "git://github.com/yorns/snc.git;protocol=https"

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

DEPENDS = "boost"

inherit cmake
inherit systemd

SYSTEMD_SERVICE_${PN} = "snc-broker.service"

SYSROOT_DIRS += "${bindir}"

do_install_append() {
  install -d ${D}${systemd_unitdir}/system
  install -m 0644 ${S}/systemd/snc-broker.service ${D}${systemd_unitdir}/system
}
