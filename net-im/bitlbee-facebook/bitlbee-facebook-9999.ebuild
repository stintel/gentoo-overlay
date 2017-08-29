# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools git-2

DESCRIPTION="Steam protocol plugin for BitlBee"
HOMEPAGE="https://github.com/bitlbee/bitlbee-facebook"
EGIT_REPO_URI="https://github.com/bitlbee/${PN}.git"

LICENSE="GPL-2 LGPL-2.1 BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	dev-libs/gmp:0
	>=net-im/bitlbee-3.2.1[plugins]"
DEPEND="${RDEPEND}
	dev-libs/glib:2
	dev-libs/json-glib
	virtual/pkgconfig"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		--enable-minimal-flags
}

src_install() {
	default
	prune_libtool_files
}
