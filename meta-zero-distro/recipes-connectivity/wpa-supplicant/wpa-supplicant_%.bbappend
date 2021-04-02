# Install wpa_supplicant configuration file

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit systemd

SRC_URI += "file://wpa_supplicant.service file://restart_ap_on_failure.service"

do_install_append() {
	install -d ${D}/${systemd_unitdir}/system
	install -m 0644 ${WORKDIR}/wpa_supplicant.service ${D}/${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/restart_ap_on_failure.service ${D}/${systemd_unitdir}/system
	install -d ${D}${sysconfdir}
	install -m 0644 ${WORKDIR}/wpa_supplicant.conf ${D}${sysconfdir}/wpa_supplicant.conf.skeleton
	rm -f ${D}${sysconfdir}/wpa_supplicant.conf
        rm -f ${D}/${systemd_unitdir}/system/wpa_supplicant-nl80211@.service
        rm -f ${D}/${systemd_unitdir}/system/wpa_supplicant-wired@.service
}

# Configure location of config file in package
CONFFILES_${PN} += "${sysconfdir}/*.conf"

FILES_${PN} += "${sysconfdir} \
           ${systemd_unitdir}/system/wpa_supplicant.service \
           ${systemd_unitdir}/system/restart_ap_on_failure.service \
"

SYSTEMD_SERVICE_${PN} = "wpa_supplicant.service restart_ap_on_failure.service"

SYSTEMD_AUTO_ENABLE_${PN} = "enable"


