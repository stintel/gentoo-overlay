# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils git-r3 systemd

EGIT_REPO_URI="git://git.linux-ipv6.be/vallumd.git"

DESCRIPTION="Centralize or distribute IP blacklists"
HOMEPAGE="https://github.com/stintel/vallumd"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="systemd"

DEPEND="app-misc/mosquitto
		net-firewall/ipset"
RDEPEND="${DEPEND}"

src_install() {
	cmake-utils_src_install

	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
	newinitd "${FILESDIR}/${PN}.init" "${PN}"

	if use systemd; then
		systemd_dounit "${FILESDIR}/${PN}.service"
	fi
}
