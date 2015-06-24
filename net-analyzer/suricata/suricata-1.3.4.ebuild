# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit user

DESCRIPTION="Suricata is a high performance Network IDS, IPS and Network Security Monitoring engine."
HOMEPAGE="http://www.openinfosecfoundation.org"
SRC_URI="http://www.openinfosecfoundation.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="caps cuda debug hardened +nfqueue"

DEPEND="dev-libs/libpcre
		dev-libs/libyaml
		cuda? (
			dev-util/nvidia-cuda-sdk
			dev-util/nvidia-cuda-toolkit
		)
		net-libs/libnet
		nfqueue? ( net-libs/libnetfilter_queue )
		net-libs/libpcap
		caps? ( sys-libs/libcap-ng )"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewuser suri -1 -1 -1
}

src_configure() {
	econf \
		$(use_enable cuda) \
		$(use_enable debug) \
		$(use_enable hardened gccprotect) \
		$(use_enable nfqueue nfqueue)
}

src_install() {
	DESTDIR="${D}" emake install

	dodir "/etc/${PN}"
	insinto "/etc/${PN}"
	doins classification.config
	doins reference.config
	doins suricata.yaml

	dodoc doc/*
}
