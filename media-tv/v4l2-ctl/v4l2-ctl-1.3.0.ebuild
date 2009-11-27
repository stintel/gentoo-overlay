# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv-utils/ivtv-utils-1.3.0-r1.ebuild,v 1.3 2009/03/03 16:48:58 beandog Exp $

inherit eutils linux-mod

MY_P="ivtv-utils-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="IVTV utilities for Hauppauge PVR PCI cards"
HOMEPAGE="http://www.ivtvdriver.org"
SRC_URI="http://dl.ivtvdriver.org/ivtv/archive/1.3.x/${MY_P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
IUSE="perl"
RDEPEND=">=sys-fs/udev-103"
DEPEND="app-arch/unzip
	>=sys-kernel/linux-headers-2.6.27
	!media-tv/ivtv-utils"

pkg_setup() {

	MODULE_NAMES="saa717x(extra:${S}/i2c-drivers)"
	BUILD_TARGETS="v4l2-ctl"
	CONFIG_CHECK="EXPERIMENTAL HAS_IOMEM FW_LOADER I2C I2C_ALGOBIT
		VIDEO_DEV VIDEO_CAPTURE_DRIVERS VIDEO_V4L1_COMPAT VIDEO_V4L2"

	if ! ( kernel_is ge 2 6 26 ); then
		eerror "This package is only for the fully in-kernel"
		eerror "IVTV driver shipping with kernel 2.6.26 and higher"
		eerror ""
		eerror "You will need to either:"
		eerror "a) emerge a 2.6.26.x or higher kernel"
		eerror "b) emerge media-tv/ivtv"
		eerror ""
		eerror "See http://ivtvdriver.org/ for more information"
		die "This only works on 2.6.26 and newer kernels"
	fi

	ewarn ""
	ewarn "Make sure that your I2C and V4L kernel drivers are loaded as"
	ewarn "modules, and not compiled into the kernel, or IVTV will not"
	ewarn "work."
	ewarn ""

	linux-mod_pkg_setup

	BUILD_PARAMS="KDIR=${KV_DIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
epatch "${FILESDIR}"/${P}-2.6.27.patch || die "epatch failed"
}

src_compile() {
	cd "${S}/utils"
	make v4l2-ctl || die "failed to build"
}

src_install() {
	cd "${S}/utils"
	dobin v4l2-ctl || die "v4l2-ctl installation failed"
	cd "${S}"
	dodoc README doc/README.devices ChangeLog
}

pkg_postinst() {
	elog ""
	elog "This ebuild will install onyl v4l2-ctl."
	elog "For the complete ivtv-utils packahe, please install ivtv-utils instead."
	elog ""
}
