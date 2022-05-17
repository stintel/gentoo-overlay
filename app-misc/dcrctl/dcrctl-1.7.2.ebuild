# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

go-module_set_globals

DESCRIPTION="dcrctl"
HOMEPAGE="https://github.com/decred/dcrd/tree/master/cmd/dcrctl"
SRC_URI="https://github.com/decred/${PN}/archive/release-v${PV}.tar.gz -> ${P}.tar.gz
		https://gentoo.adlevio.net/${P}-deps.tar.xz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-release-v${PV}"

src_compile() {
	go build || die
}

src_install() {
	dobin dcrctl
}
