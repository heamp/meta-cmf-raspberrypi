require ccsp_common_rpi.inc

do_install_append () {
    ln -sf ${bindir}/dmcli ${D}${bindir}/ccsp_bus_client_tool
    ln -sf ${bindir}/dmcli ${D}/usr/ccsp/ccsp_bus_client_tool
}
