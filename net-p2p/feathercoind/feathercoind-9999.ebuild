# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DB_VER="4.8"

inherit autotools db-use eutils user

MyPN="${PN/d$/}"
MyP="${MyPN}-${PV}"

DESCRIPTION="Original Feathercoin crypto-currency wallet for automated services"
HOMEPAGE="http://feathercoin.org/"

case ${PV} in
	9999)
		KEYWORDS=""
		inherit git-r3
		EGIT_REPO_URI="git://github.com/FeatherCoin/FeatherCoin.git"
		EGIT_BRANCH='0.9.3'
		;;
	*)
		KEYWORDS="~amd64"
		SRC_URI="https://github.com/FeatherCoin/FeatherCoin/archive/v${PV}.tar.gz -> ${MyP}.tar.gz"
esac

LICENSE="MIT ISC GPL-2"
SLOT="0"
IUSE="examples ipv6 logrotate test upnp wallet"

RDEPEND="
	>=dev-libs/boost-1.41.0[threads(+)]
	dev-libs/openssl:0[-bindist]
	logrotate? (
		app-admin/logrotate
	)
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	virtual/bitcoin-leveldb
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
"

pkg_setup() {
	local UG='feathercoin'
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/feathercoin "${UG}"
}

src_prepare() {
	epatch "${FILESDIR}/feathercoin-sys_leveldb.patch"
	eautoreconf
}

src_configure() {
	econf \
		--disable-ccache \
		$(use_with upnp miniupnpc) $(use_enable upnp upnp-default) \
		$(use_enable test tests)  \
		$(use_enable wallet)  \
		--with-system-leveldb  \
		--without-cli  \
		--without-gui
}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${D}" install

	insinto /etc/feathercoin
	newins "${FILESDIR}/feathercoin.conf" feathercoin.conf
	fowners feathercoin:feathercoin /etc/feathercoin/feathercoin.conf
	fperms 600 /etc/feathercoin/feathercoin.conf

	newconfd "${FILESDIR}/feathercoin.confd" ${PN}
	newinitd "${FILESDIR}/feathercoin.initd" ${PN}

	keepdir /var/lib/feathercoin/.feathercoin
	fperms 700 /var/lib/feathercoin
	fowners feathercoin:feathercoin /var/lib/feathercoin/
	fowners feathercoin:feathercoin /var/lib/feathercoin/.feathercoin
	dosym /etc/feathercoin/feathercoin.conf /var/lib/feathercoin/.feathercoin/feathercoin.conf

	dodoc doc/README.md

	if use examples; then
		docinto examples
		dodoc -r contrib/{bitrpc,pyminer,wallettools}
	fi

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/feathercoind.logrotate" feathercoind
	fi
}
