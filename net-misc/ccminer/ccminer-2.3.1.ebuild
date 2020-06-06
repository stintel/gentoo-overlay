# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools cuda flag-o-matic versionator

DESCRIPTION="Bitcoin CPU/GPU/FPGA miner in C"
HOMEPAGE="https://bitcointalk.org/index.php?topic=28402.0"
SRC_URI="https://github.com/tpruvot/${PN}/archive/${PV}-tpruvot.tar.gz -> ccminer-v${PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="hardened"

DEPEND="
	net-misc/curl
	dev-libs/jansson
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-tpruvot"

src_prepare() {
	default
	cuda_src_prepare
	export CUDA_CFLAGS=$NVCCFLAGS
	eautoreconf
}

src_configure() {
	strip-flags
	filter-flags -ggdb -pipe -m*
	append-cppflags -I/opt/cuda/include
	append-ldflags -L/opt/cuda/lib64
	use hardened && append-cppflags -no-pie

	default
}

src_install() {
	dobin ccminer
	dodoc README.txt
}
