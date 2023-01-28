# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Client-side package and programs for forwarding ADS-B data to FlightAware"
HOMEPAGE="https://flightaware.com/adsb/piaware/"
SRC_URI="https://github.com/flightaware/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		dev-tcltk/tcllauncher
		dev-tcltk/tcllib
		dev-tcltk/tls
		net-wireless/dump1090"
BDEPEND="acct-group/piaware acct-user/piaware dev-tcltk/itcl"

PATCHES=( "${FILESDIR}/${P}-fix-iproute-path.patch" )

src_install() {
	default

	keepdir /etc/piaware
	fowners piaware:piaware /etc/piaware
	fperms 700 /etc/piaware

	newconfd "${FILESDIR}/piaware.conf" piaware
	newinitd "${FILESDIR}/piaware.init" piaware

	keepdir /var/cache/piaware
	fowners piaware:piaware /var/cache/piaware
}
