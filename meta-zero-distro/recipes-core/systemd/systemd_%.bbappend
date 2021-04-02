# Add wired and wireless network configs
# See: https://github.com/gumstix/meta-gumstix-extras/blob/rocko/recipes-core/systemd/systemd_%25.bbappend
# and: http://www.freedesktop.org/software/systemd/man/systemd.network.html

#PACKAGECONFIG_append = " networkd resolved"
#DEPENDS += " bash "
RDEPENDS_${PN} += " bash "

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://wireless.ap.network \
    file://wireless.client.network \
    file://resolved.conf \
    file://restartAPonFailure.sh \
    file://wpa_generate.sh \
    "

do_install_append() {
	install -d ${D}${base_libdir}/systemd/network/
	install -m 0644 ${WORKDIR}/wireless.ap.network ${D}${base_libdir}/systemd/network/60-wireless.ap.network
        install -m 0644 ${WORKDIR}/wireless.client.network ${D}${base_libdir}/systemd/network/80-wireless.client.network
        install -m 0644 ${WORKDIR}/resolved.conf ${D}${base_libdir}/systemd/resolved.conf
        install -d ${D}${bindir}
        install -m 0777 ${WORKDIR}/*.sh ${D}${bindir}
#        install -d ${D}/${systemd_unitdir}/system
#        lnr ${D}${sysconfdir}/systemd/network/wireless.ap.network ${D}${sysconfdir}/systemd/network/wireless.network
        # is there any effect in this?
#	ln -s /run/systemd/resolve/resolv.conf ${D}${sysconfdir}/resolv.conf
}

#USERADD_PARAM_${PN} += "--system --home /dev/null systemd-journal-gateway"

FILES_${PN} += "${base_libdir}/systemd \
                ${bindir} \
                "

