# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit cmake

DESCRIPTION="lightweight automatic anti-bot turret for your public serivces"
HOMEPAGE="https://github.com/AdUser/f2b"
SRC_URI="https://github.com/AdUser/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+client +csocket hardened mcast +pcre redis"

REQUIRED_USE="client? ( csocket )"

DEPEND="pcre? ( dev-libs/libpcre )
		redis? ( dev-db/redis )"
RDEPEND="${DEPEND}"

src_prepare() {
	eapply "${FILESDIR}/${P}-openrc-compat.patch"

	default
}

src_configure() {
	local mycmakeargs=($
		-DENABLE_CLIENT=$(usex client)
		-DENABLE_CSOCKET=$(usex csocket)
		-DENABLE_HARDENING=$(usex hardened)
		-DENABLE_MCAST=$(usex mcast)
		-DENABLE_PCRE=$(usex pcre)
		-DENABLE_REDIS=$(usex redis)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	newinitd "${S}/contrib/init.openrc" "${PN}"
}
