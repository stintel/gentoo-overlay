# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Readsb is a Mode-S/ADSB/TIS decoder"
HOMEPAGE="https://github.com/Mictronics/readsb-protobuf"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Mictronics/${PN}.git"
	KEYWORDS="~amd64 ~riscv"
else
	KEYWORDS="amd64 ~riscv"
	SRC_URI="https://github.com/Mictronics/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="BSD"
SLOT="0"
IUSE="bladerf +rtlsdr plutosdr"

RDEPEND="dev-libs/protobuf-c
		net-analyzer/rrdtool
		plutosdr? ( net-libs/libad9361-iio )
		bladerf? ( net-wireless/bladerf:= )
		rtlsdr? ( net-wireless/rtl-sdr:= )
		sys-libs/ncurses:=
		virtual/libusb:1"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	sed -i 's#-O2 -g##' Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" \
		BLADERF=$(usex bladerf) \
		PLUTOSDR=$(usex plutosdr) \
		RTLSDR=$(usex rtlsdr)
}

src_install() {
	dobin readsb
	dobin viewadsb
	dodoc README.md

	insinto /usr/share/${PN}/html
	doins -r webapp/src/*

	insinto /usr/share/${PN}
	newins debian/lighttpd/89-readsb.conf lighttpd.conf
}
