# Install wpa_supplicant configuration file

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit systemd

SRC_URI += "file://wpa_supplicant.conf file://wpa_supplicant.service file://resolved.conf"

do_install_append() {
	install -d ${D}${sysconfdir}
	install -m 0644 ${WORKDIR}/wpa_supplicant.conf ${D}${sysconfdir}/wpa_supplicant.conf
	install -d ${D}${sysconfdir}/systemd
	install -m 0644 ${WORKDIR}/resolved.conf ${D}${sysconfdir}/systemd/resolved.conf
	install -d ${D}/${systemd_unitdir}/system
	install -m 0644 ${WORKDIR}/wpa_supplicant.service ${D}/${systemd_unitdir}/system
}


# Configure location of config file in package
CONFFILES_${PN} += "${sysconfdir}/*.conf"

SYSTEMD_AUTO_ENABLE = "enable"

