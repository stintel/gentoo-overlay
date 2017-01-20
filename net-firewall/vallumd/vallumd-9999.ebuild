# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

if [ "${PV}" = 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/stintel/vallumd.git"
else
	KEYWORDS="~amd64 ~mips ~x86"
	SRC_URI="https://github.com/stintel/${PN}/archive/${PV}/${P}.tar.gz"
fi

DESCRIPTION="Centralize or distribute IP blacklists"
HOMEPAGE="https://github.com/stintel/vallumd"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="app-misc/mosquitto
		net-firewall/ipset"
RDEPEND="${DEPEND}"
