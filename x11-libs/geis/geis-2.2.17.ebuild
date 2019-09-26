# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit python-any-r1

DESCRIPTION="An implementation of the GEIS (Gesture Engine Interface and Support) interface."
HOMEPAGE="https://launchpad.net/geis"
SRC_URI="https://launchpad.net/geis/trunk/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="evemu"

CDEPEND="evemu? ( app-misc/evemu )
		dev-libs/check
		dev-libs/frame[X]
		dev-libs/grail
		sys-apps/dbus
		x11-base/xorg-server
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libxcb"
DEPEND="${CDEPEND}
		virtual/pkgconfig"
RDEPEND="${CDEPEND}"

src_prepare() {
	eapply "${FILESDIR}/${P}-trunk-r337.patch"
	eapply "${FILESDIR}/${P}-fix-pointer-compare.patch"
	default
}

src_configure() {
	econf \
		$(use_with evemu) || die
}
