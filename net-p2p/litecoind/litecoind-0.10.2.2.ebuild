# Copyright 2010-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/litecoind/litecoind-0.9.4.ebuild,v 1.1 2015/02/23 21:31:45 blueness Exp $

EAPI=5

DB_VER="5.1"

inherit autotools bash-completion-r1 bitcoincore db-use eutils user versionator systemd

MyPV="${PV/_/}"
MyPN="litecoin"
MyP="${MyPN}-${MyPV}"

DESCRIPTION="Litecoin crypto-currency wallet for automated services"
HOMEPAGE="http://litecoin.org/"
SRC_URI="https://github.com/${MyPN}-project/${MyPN}/archive/v${MyPV}.tar.gz -> ${MyP}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="examples logrotate test upnp +wallet"

RDEPEND="
	>=dev-libs/boost-1.41.0[threads(+)]
	dev-libs/openssl:0[-bindist]
	logrotate? (
		app-admin/logrotate
	)
	upnp? (
		net-libs/miniupnpc
	)
	wallet? (
		sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	)
	virtual/bitcoin-leveldb
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
	sys-apps/sed
"

S="${WORKDIR}/${MyP}"

pkg_setup() {
	local UG='litecoin'
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/litecoin "${UG}"
}

src_prepare() {
	epatch "${FILESDIR}/litecoin-sys_leveldb.patch"
	epatch "${FILESDIR}/${P}-sys-leveldb.patch"
	rm -r src/leveldb
	eautoreconf

	sed -i 's/bitcoin/litecoin/g;s/Bitcoin/Litecoin/g;s/BITCOIN/LITECOIN/g' \
		contrib/init/bitcoind.openrc \
		contrib/init/bitcoind.openrcconf
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

	insinto /etc/litecoin
	newins "${FILESDIR}/litecoin.conf" litecoin.conf
	fowners litecoin:litecoin /etc/litecoin/litecoin.conf
	fperms 600 /etc/litecoin/litecoin.conf

	newconfd "contrib/init/bitcoind.openrcconf" ${PN}.conf
	newinitd "contrib/init/bitcoind.openrc" ${PN}
	systemd_dounit "${FILESDIR}/litecoind.service"

	keepdir /var/lib/litecoin/.litecoin
	fperms 700 /var/lib/litecoin
	fowners litecoin:litecoin /var/lib/litecoin/
	fowners litecoin:litecoin /var/lib/litecoin/.litecoin
	dosym /etc/litecoin/litecoin.conf /var/lib/litecoin/.litecoin/litecoin.conf

	dodoc doc/README.md doc/release-notes.md
	dodoc doc/tor.md
	newman contrib/debian/manpages/bitcoind.1 litecoind.1
	newman contrib/debian/manpages/bitcoin.conf.5 litecoin.conf.5

	newbashcomp contrib/bitcoind.bash-completion ${PN}

	if use examples; then
		docinto examples
		dodoc -r contrib/{bitrpc,pyminer,qos,spendfrom,tidy_datadir.sh}
	fi

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/litecoind.logrotate" litecoind
	fi
}
