# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Gesture Recognition And Instantiation Library"
HOMEPAGE="https://launchpad.net/grail"
SRC_URI="https://launchpad.net/grail/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X"

CDEPEND="app-text/asciidoc
		dev-libs/frame
		X? (
			dev-libs/frame[X]
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
		$(use_with X x11) || die
}
