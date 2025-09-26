FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

CFLAGS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'halVersion3', ' -DWIFI_HAL_VERSION_3 ', '', d)}"

SRC_URI_remove = "git://github.com/rdkcentral/rdkb-halif-wifi.git;protocol=https;branch=main"
SRC_URI += "git://github.com/rdkcentral/rdkb-halif-wifi.git;protocol=https;branch=develop"

SRCREV = "33b416471090929422a0b03a6a76d5bf5a36eb3a"


SRC_URI += "file://sta-network.patch"

