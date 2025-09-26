FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'telemetry2_0', 'telemetry', '', d)}"
LDFLAGS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'telemetry2_0', ' -ltelemetry_msgsender ', '', d)}"

SYSTEMD_AUTO_ENABLE_${PN} = "enable"
SRC_URI_append = " 		 \
    file://hostapd0.conf \
    file://hostapd1.conf \
    file://hostapd4.conf \
    file://hostapd5.conf \
    file://sec_file.txt  \
    file://bw_file.txt  \
    file://hostapd.service \
    file://hostapd_start.sh \
    file://defconfig \
    file://backup_checkup_hostapd.sh \
    file://hostapd-2G.conf \
    file://hostapd-5G.conf \
    file://hostapd-bhaul2G.conf \
    file://hostapd-bhaul5G.conf \
    file://hostapd_init.sh \
    file://hostapd_opensync.sh \
"
SRC_URI_append_extender = " \
    ${@bb.utils.contains("DISTRO_FEATURES", "kirkstone", "", "file://nl80211-relax-bridge-setup.patch",  d)} \
    file://hostapd2.conf \
    file://hostapd3.conf \
    file://extender_hostapd_start.sh \
    file://extender_hostapd0.conf \
    file://extender_hostapd1.conf \
    file://extender_hostapd2.conf \
    file://extender_hostapd3.conf \
    file://disable_pi_wifi.conf \
    file://make_homeap_primary.sh \
    file://make_bhaul_50_primary.sh \
"

do_install_append() {
    install -d ${D}${sysconfdir}
    install -d ${D}/usr/ccsp/wifi/
    install -d ${D}${prefix}/hostapd
    install -d ${D}${sysconfdir}/hostapd
    install -m 755 ${WORKDIR}/hostapd0.conf ${D}/usr/ccsp/wifi/
    install -m 755 ${WORKDIR}/hostapd1.conf ${D}/usr/ccsp/wifi/
    install -m 755 ${WORKDIR}/hostapd4.conf ${D}/usr/ccsp/wifi/
    install -m 755 ${WORKDIR}/hostapd5.conf ${D}/usr/ccsp/wifi/
    install -m 755 ${WORKDIR}/hostapd-2G.conf ${D}/usr/ccsp/wifi/
    install -m 755 ${WORKDIR}/hostapd-5G.conf ${D}/usr/ccsp/wifi/
    install -m 755 ${WORKDIR}/hostapd-bhaul2G.conf ${D}/usr/ccsp/wifi/
    install -m 755 ${WORKDIR}/hostapd-bhaul5G.conf ${D}/usr/ccsp/wifi/
    install -m 755 ${WORKDIR}/sec_file.txt ${D}${sysconfdir}
    install -m 755 ${WORKDIR}/bw_file.txt ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/hostapd.service ${D}${systemd_unitdir}/system/
    install -m 755 ${WORKDIR}/hostapd_start.sh ${D}${prefix}/hostapd/
    install -m 755 ${WORKDIR}/hostapd_init.sh ${D}${prefix}/hostapd/
    install -m 755 ${WORKDIR}/hostapd_opensync.sh ${D}${prefix}/hostapd/
    install -m 755 ${WORKDIR}/backup_checkup_hostapd.sh  ${D}${prefix}/hostapd/
}

do_install_append_aarch64() {
    sed -i "s/ExecStart=\/bin\/sh -c '\/usr\/hostapd\/hostapd_init.sh'/ExecStart=\/bin\/sh -c '\/usr\/hostapd\/hostapd_start.sh'/g"  ${D}${systemd_unitdir}/system/hostapd.service     	
}

do_install_extender() {
    sed -i '/^After=CcspPandMSsp.service/ a StartLimitIntervalSec=120' ${WORKDIR}/hostapd.service
    sed -i '/^ExecStart=/ a Restart=always' ${WORKDIR}/hostapd.service
    sed -i '/^After=CcspPandMSsp.service/d' ${WORKDIR}/hostapd.service
    sed -i '/PIDFile=/c\PIDFile=/var/run/hostapd-global.pid' ${WORKDIR}/hostapd.service
    sed -i "$ a [Install]\nWantedBy=multi-user.target" ${WORKDIR}/hostapd.service
    install -d ${D}${sysconfdir} ${D}${systemd_unitdir}/system/ ${D}${sbindir}
    install -d ${D}/usr/ccsp/wifi/
    install -d ${D}${prefix}/hostapd
    install -d ${D}${sysconfdir}/modprobe.d/
    install -m 0755 ${B}/hostapd ${D}${sbindir}
    install -m 0755 ${B}/hostapd_cli ${D}${sbindir}
    install -m 644 ${WORKDIR}/extender_hostapd0.conf ${D}/usr/ccsp/wifi/
    install -m 644 ${WORKDIR}/extender_hostapd1.conf ${D}/usr/ccsp/wifi/
    install -m 644 ${WORKDIR}/extender_hostapd2.conf ${D}/usr/ccsp/wifi/
    install -m 644 ${WORKDIR}/extender_hostapd3.conf ${D}/usr/ccsp/wifi/
    install -m 644 ${WORKDIR}/disable_pi_wifi.conf ${D}${sysconfdir}/modprobe.d/
    install -m 644 ${WORKDIR}/hostapd.service ${D}${systemd_unitdir}/system/
    install -m 755 ${WORKDIR}/extender_hostapd_start.sh ${D}${prefix}/hostapd/hostapd_init.sh
    install -m 755 ${WORKDIR}/make_homeap_primary.sh ${D}${prefix}/hostapd/
    install -m 755 ${WORKDIR}/make_bhaul_50_primary.sh ${D}${prefix}/hostapd/
    exit 0
}

FILES_${PN} += " \
	${prefix}/hostapd/* \
	${sysconfdir}/hostapd/* \
	${prefix}/ccsp/wifi/hostapd0.conf \
	${prefix}/ccsp/wifi/hostapd1.conf \
	${prefix}/ccsp/wifi/hostapd4.conf \
	${prefix}/ccsp/wifi/hostapd5.conf \
	${prefix}/ccsp/wifi/hostapd-2G.conf \
	${prefix}/ccsp/wifi/hostapd-5G.conf \
	${prefix}/ccsp/wifi/hostapd-bhaul2G.conf \
	${prefix}/ccsp/wifi/hostapd-bhaul5G.conf \
"

FILES_${PN}_extender += " \
	${prefix}/hostapd/* \
	${sbindir}/hostapd* \
	${prefix}/ccsp/wifi/extender_hostapd0.conf \
	${prefix}/ccsp/wifi/extender_hostapd1.conf \
	${prefix}/ccsp/wifi/extender_hostapd2.conf \
	${prefix}/ccsp/wifi/extender_hostapd3.conf \
	${sysconfdir}/modprobe.d/disable_pi_wifi.conf \
"
