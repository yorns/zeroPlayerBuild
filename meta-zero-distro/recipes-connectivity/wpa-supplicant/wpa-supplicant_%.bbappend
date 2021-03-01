# Install wpa_supplicant configuration file

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit systemd

SRC_URI += "file://wpa_supplicant.service"

do_install_append() {
	install -d ${D}/${systemd_unitdir}/system
	install -m 0644 ${WORKDIR}/wpa_supplicant.service ${D}/${systemd_unitdir}/system
	install -d ${D}${sysconfdir}
	install -m 0644 ${WORKDIR}/wpa_supplicant.conf ${D}${sysconfdir}/wpa_supplicant.conf.skeleton
	rm -f ${D}${sysconfdir}/wpa_supplicant.conf
}

# Configure location of config file in package
CONFFILES_${PN} += "${sysconfdir}/*.conf"

SYSTEMD_AUTO_ENABLE_${PN} = "enable"


