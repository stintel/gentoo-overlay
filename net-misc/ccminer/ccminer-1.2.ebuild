# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit autotools flag-o-matic versionator

DESCRIPTION="Bitcoin CPU/GPU/FPGA miner in C"
HOMEPAGE="https://bitcointalk.org/index.php?topic=28402.0"
SRC_URI="https://github.com/cbuchner1/${PN}/archive/v${PV}.tar.gz -> ccminer-v${PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="hardened"

DEPEND="
	net-misc/curl
	dev-libs/jansson
"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	strip-flags
	filter-flags -ggdb -pipe -m*
	append-ldflags -L/opt/cuda/lib64
	local CFLAGS="${CFLAGS}"
	use hardened && CFLAGS="${CFLAGS} -nopie"

	CFLAGS="${CFLAGS}" \
	econf
}

src_install() {
	dobin ccminer
	dodoc README.txt
}
