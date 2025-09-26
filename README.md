**RPI4 Easy mesh build instructions for controller.**

repo init -u https://github.com/heamp/rdkcmf -b main -m rdkb-extsrc_em.xml\
repo sync -j`nproc` --no-clone-bundle\
MACHINE=raspberrypi4-64-rdk-broadband source meta-cmf-raspberrypi/setup-environment\
bitbake rdk-generic-broadband-image\

---------------------------------------------------------------------------------------------------
**RPI 4 Easy Mesh Build instructions for extender agent.**

repo init -u https://github.com/heamp/rdkcmf -b main -m rdkb-pod-extsrc.xml\
repo sync -j`nproc` --no-clone-bundle\
MACHINE=raspberrypi4-rdk-extender source meta-cmf-raspberrypi/setup-environment\
bitbake rdk-generic-extender-image\
