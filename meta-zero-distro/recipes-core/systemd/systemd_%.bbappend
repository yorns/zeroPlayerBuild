# Add wired and wireless network configs
# See: https://github.com/gumstix/meta-gumstix-extras/blob/rocko/recipes-core/systemd/systemd_%25.bbappend
# and: http://www.freedesktop.org/software/systemd/man/systemd.network.html

#PACKAGECONFIG_append = " networkd resolved"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://wired.network \
    file://wireless.ap.network \
    file://wireless.client.network \
    file://resolved.conf \
    "

do_install_append() {
	install -d ${D}${sysconfdir}/systemd/network/
	install -m 0644 ${WORKDIR}/*.network ${D}${sysconfdir}/systemd/network/
        install -m 0644 ${WORKDIR}/resolved.conf ${D}${sysconfdir}/systemd/resolved.conf
        install -d ${D}/${systemd_unitdir}/system
        lnr ${D}${sysconfdir}/systemd/network/wireless.ap.network ${D}${sysconfdir}/systemd/network/wireless.network
	ln -s /run/systemd/resolve/resolv.conf ${D}${sysconfdir}/resolv.conf
}

#USERADD_PARAM_${PN} += "--system --home /dev/null systemd-journal-gateway"

FILES_${PN} += "${sysconfdir}"
