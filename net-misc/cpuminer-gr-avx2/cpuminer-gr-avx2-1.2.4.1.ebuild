# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Optimised Version of GR miner for RTM"
HOMEPAGE="https://github.com/WyvernTKC/cpuminer-gr-avx2"
SRC_URI="https://github.com/WyvernTKC/cpuminer-gr-avx2/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	app-arch/zstd
	dev-libs/libunistring
	dev-libs/openssl:0=
	net-dns/c-ares
	net-dns/libidn2
	net-libs/nghttp2
	net-misc/curl[ssl]
	sys-libs/zlib
	sys-process/numactl"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	export with_curl="yes"
	default
}
