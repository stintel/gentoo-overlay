# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Filesystem partitioner"
HOMEPAGE="https://www.fpart.org/"
SRC_URI="https://github.com/martymac/fpart/archive/refs/tags/${P}.tar.gz"

S="${WORKDIR}/${PN}-${P}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""


src_prepare() {
	default

	eautoreconf || die
}
