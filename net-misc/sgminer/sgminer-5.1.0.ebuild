# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sgminer/sgminer-2.7.4.ebuild,v 1.1 2012/08/30 21:30:41 blueness Exp $

EAPI="4"

inherit autotools versionator

#MY_PV="$(delete_all_version_separators)"
#S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="Bitcoin CPU/GPU/FPGA miner in C"
HOMEPAGE="https://bitcointalk.org/index.php?topic=28402.0"
SRC_URI="https://github.com/sgminer-dev/sgminer/archive/${PV}.tar.gz -> sgminer-v${PV}.tgz"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="+adl examples hardened ncurses +opencl scrypt +udev"
REQUIRED_USE="
	adl? ( opencl )
	opencl? ( ncurses )
	scrypt? ( opencl )
"

DEPEND="
	net-misc/curl
	ncurses? (
		sys-libs/ncurses
	)
	>=dev-libs/jansson-2.5
	opencl? (
		virtual/opencl
	)
	udev? (
		virtual/udev
	)
"
RDEPEND="${DEPEND}"
DEPEND="${DEPEND}
	virtual/pkgconfig
	sys-apps/sed
	adl? (
		>=x11-libs/amd-adl-sdk-6.0
	)
"

src_prepare() {
	use adl && ln -s /usr/include/ADL/* ADL_SDK/

	epatch "${FILESDIR}/${P}-system-jansson.patch"

	eautoreconf
}

src_configure() {
	local CFLAGS="${CFLAGS}"
	use hardened && CFLAGS="${CFLAGS} -nopie"

	CFLAGS="${CFLAGS}" \
	econf \
		$(use_enable adl) \
		$(use_with ncurses curses) \
		$(use_enable opencl) \
		$(use_enable scrypt) \
		$(use_with udev libudev) \
	# sanitize directories
	sed -i 's~^\(\#define SGMINER_PREFIX \).*$~\1"'"${EPREFIX}/usr/lib/sgminer"'"~' config.h
}

src_install() {
	dobin sgminer
	dodoc AUTHORS.md NEWS.md README.md
	if use opencl; then
		insinto /usr/lib/sgminer
		doins kernel/*.cl
	fi
	if use examples; then
		docinto examples
		dodoc api-example.php miner.php API.java api-example.c
	fi
}
