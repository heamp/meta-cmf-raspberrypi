FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append_broadband = " file://kernel_5_15_kirkstone.cfg"
SRC_URI += " \
             file://test_lockup.cfg \
             file://test_lockup_5_15.patch \
"
