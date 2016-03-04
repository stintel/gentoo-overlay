# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Frame handles the buildup and synchronization of a set of simultaneous touches."
HOMEPAGE="https://launchpad.net/frame"
SRC_URI="https://launchpad.net/frame/trunk/v${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X"

CDEPEND="app-text/asciidoc
		X? (
			x11-base/xorg-server
			x11-libs/libdrm
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXi
			x11-libs/pixman
			x11-proto/inputproto
			x11-proto/xf86driproto
		)"
DEPEND="${CDEPEND}
		virtual/pkgconfig"
RDEPEND="${CDEPEND}"

src_configure() {
	econf \
		$(use_enable X x11) || die
}
