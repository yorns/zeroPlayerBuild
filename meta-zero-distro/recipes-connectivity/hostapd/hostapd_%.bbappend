# Install wpa_supplicant configuration file

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit systemd

SRC_URI += "file://hostapd.conf file://hostapd.service"

do_install_append() {
	install -d ${D}${sysconfdir}
	install -m 0644 ${WORKDIR}/hostapd.conf ${D}${sysconfdir}/hostapd.conf
	install -m 0644 ${WORKDIR}/udhcpd.conf ${D}${sysconfdir}/udhcpd.conf
}

# Configure location of config file in package
CONFFILES_${PN} += "${sysconfdir}/*.conf"

SYSTEMD_AUTO_ENABLE_${PN} = "enable"

