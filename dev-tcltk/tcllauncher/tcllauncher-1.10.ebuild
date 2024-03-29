# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A launcher program for Tcl applications."
HOMEPAGE="https://flightaware.github.io/tcllauncher/"
SRC_URI="https://github.com/flightaware/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} dev-tcltk/tclx"
BDEPEND=""

src_prepare() {
	default
	eautoreconf
}
