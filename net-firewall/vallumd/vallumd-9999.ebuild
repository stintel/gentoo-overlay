# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils git-r3

EGIT_REPO_URI="https://github.com/stintel/vallumd.git"

DESCRIPTION="Centralize or distribute IP blacklists"
HOMEPAGE="https://github.com/stintel/vallumd"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="app-misc/mosquitto
		net-firewall/ipset"
RDEPEND="${DEPEND}"

src_install() {
	cmake-utils_src_install

	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
}
