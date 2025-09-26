# Downgrading RPI firmware since there is video playback issue in Kirkstone builds (RDKVREFPLT-3131) which is caused by a commit after this FW release.
# See https://github.com/agherzan/meta-raspberrypi/issues/1370

RPIFW_DATE = "20210831"

SRC_URI[sha256sum] = "a5055796e39efd874c5bccb689b909f39b20705f6ed32f8274c785a376369369"
