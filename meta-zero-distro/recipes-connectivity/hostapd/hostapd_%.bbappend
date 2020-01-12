# Install wpa_supplicant configuration file

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit systemd

SRC_URI += "file://hostapd.conf file://hostapd.service"

do_install_append() {
#	install -d ${D}${sysconfdir}/wpa_supplicant
	install -m 0644 ${WORKDIR}/hostapd.conf ${D}${sysconfdir}/hostapd.conf

	# link instance-specific units---this is equivalent to calling
        #   $ systemctl enable wpa_supplicant@wlan0
        # on the target system.
	install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
        ln -s ${base_libdir}/systemd/system/hostapd.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/hostapd.service
}

# Configure location of config file in package
CONFFILES_${PN} += "${sysconfdir}/*.conf"

SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE_${PN}_append = " hostapd.service"

