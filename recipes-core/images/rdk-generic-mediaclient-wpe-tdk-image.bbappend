IMAGE_FEATURES += "tdk"

IMAGE_INSTALL_append = " \
   bluealsa  \
   packagegroup-tdk \
   hdhomerun \
   rdkapps \
   parodus \
   tr69hostif \
   alsa-utils \
   alsa-lib \
"

IMAGE_INSTALL_remove = " \
    westeros-init \
    wpe-webkit-init \
"

PACKAGE_EXCLUDE_pn-rdk-generic-mediaclient-westeros-wpe-tdk-image = "${@bb.utils.contains('DISTRO_FEATURES','ENABLE_IPK','packagegroup-tdk','',d)}"

ROOTFS_POSTPROCESS_COMMAND += "append_version; "

append_version() {
        echo "JENKINS_JOB=0" >> ${IMAGE_ROOTFS}/version.txt
        echo "JENKINS_BUILD_NUMBER=0" >> ${IMAGE_ROOTFS}/version.txt
}

fixes_tty1_removal() {
    if [ -f ${IMAGE_ROOTFS}/etc/systemd/system/getty.target.wants/getty@tty1.service ]; then
            rm -f "${IMAGE_ROOTFS}/etc/systemd/system/getty.target.wants/getty@tty1.service"
    fi
}
