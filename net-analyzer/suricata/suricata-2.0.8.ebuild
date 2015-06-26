# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit confutils flag-o-matic python-single-r1 user

DESCRIPTION="Suricata is a high performance Network IDS, IPS and Network Security Monitoring engine."
HOMEPAGE="http://www.openinfosecfoundation.org"
SRC_URI="http://www.openinfosecfoundation.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="caps cuda debug geoip +hardened lua luajit nflog nfqueue unix-socket"

DEPEND="lua? ( dev-lang/lua:0 )
		luajit? ( dev-lang/luajit:2 )
		geoip? ( dev-libs/geoip )
		unix-socket? ( dev-libs/jansson )
		dev-libs/libpcre
		dev-libs/libyaml
		cuda? (
			dev-util/nvidia-cuda-sdk
			dev-util/nvidia-cuda-toolkit
		)
		net-libs/libnet:1.1
		nflog? ( net-libs/libnetfilter_log )
		nfqueue? ( net-libs/libnetfilter_queue )
		net-libs/libpcap
		sys-apps/file
		caps? ( sys-libs/libcap-ng )"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewuser suri -1 -1 -1

	python-single-r1_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-configure.patch"
}

src_configure() {
	append-cflags -D_DEFAULT_SOURCE

	econf \
		--localstatedir=/var/ \
		$(use_enable cuda) \
		$(use_enable debug) \
		$(use_enable hardened gccprotect) \
		$(use_enable nfqueue) \
		$(use_enable unix-socket) \
		$(usex nflog --enable-nflog '')
}

src_install() {
	emake DESTDIR="${D}" install

	newinitd "${FILESDIR}/${PN}.initd" ${PN}

	dodir "/etc/${PN}"
	insinto "/etc/${PN}"
	doins classification.config
	doins reference.config
	doins suricata.yaml
	doins threshold.config

	diropts -o suri -g suri -m 750
	dodir "/var/log/${PN}"

	dodoc doc/*
}
