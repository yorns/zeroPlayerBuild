DESCRIPTION = "rfid reader and population"
LICENSE = "CLOSED"
# LIC_FILES_CHKSUM = "file://LICENSE;md5=254d223b9e70204fcb33cd46be4df2d7"

SRCBRANCH = "master"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI = "git://github.com/yorns/piRfidReader.git;protocol=https;branch=${SRCBRANCH} \
           file://spi_rfid.service \
          "

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

DEPENDS = "boost snc nlohmann-json"
RDEPENDS_${PN} = "snc"

inherit cmake
inherit systemd

SYSTEMD_SERVICE_${PN} = "spi_rfid.service"

do_install_append() {
  install -d ${D}${systemd_unitdir}/system
  install -m 0644 ${WORKDIR}/*.service ${D}${systemd_unitdir}/system
  install -d ${D}${bindir}
  install -d ${D}${localstatedir}/audioserver/stick
}

FILES_${PN} = "\
${bindir}/spi_rfid \
${bindir}/read_rfid \
${bindir}/requester \
${localstatedir}/audioserver/stick/keyTable.json \
"

