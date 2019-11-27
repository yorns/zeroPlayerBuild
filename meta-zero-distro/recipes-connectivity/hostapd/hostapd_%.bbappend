# Install wpa_supplicant configuration file

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://hostapd.conf"

do_install_append() {
#	install -d ${D}${sysconfdir}/wpa_supplicant
	install -m 0644 ${WORKDIR}/hostapd.conf ${D}${sysconfdir}/hostapd.conf

	# link instance-specific units---this is equivalent to calling
        #   $ systemctl enable wpa_supplicant@wlan0
        # on the target system.
#	install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
#        ln -s ${systemd_unitdir}/wpa_supplicant@.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/wpa_supplicant@wlan0.service
}

# Configure location of config file in package
CONFFILES_${PN} += "${sysconfdir}/*.conf"

SYSTEMD_AUTO_ENABLE = "enable"
#SYSTEMD_SERVICE_${PN}_append = " wpa_supplicant-wlan0.conf"
