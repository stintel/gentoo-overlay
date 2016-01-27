# Copyright 2010-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dogecoind/dogecoind-0.9.4.ebuild,v 1.1 2015/02/23 21:31:45 blueness Exp $

EAPI=4

DB_VER="4.8"

inherit autotools bash-completion-r1 db-use eutils user versionator systemd

MyPV="${PV/_/}"
MyPN="dogecoin"
MyP="${MyPN}-${MyPV}"

DESCRIPTION="Dogecoin crypto-currency wallet for automated services"
HOMEPAGE="http://dogecoin.org/"
SRC_URI="https://github.com/${MyPN}/${MyPN}/archive/v${MyPV}.tar.gz -> ${MyPN}-v${PV}.tgz
"

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
	local UG='dogecoin'
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/dogecoin "${UG}"
}

src_prepare() {
	epatch "${FILESDIR}/${MyPN}-1.10.0-bdb48.patch"
	epatch "${FILESDIR}/${PN}-1.8.3-sys_leveldb.patch"
	rm -r src/leveldb
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

	insinto /etc/dogecoin
	newins "${FILESDIR}/dogecoin.conf" dogecoin.conf
	fowners dogecoin:dogecoin /etc/dogecoin/dogecoin.conf
	fperms 600 /etc/dogecoin/dogecoin.conf

	newconfd "contrib/init/dogecoind.openrcconf" ${PN}
	newinitd "contrib/init/dogecoind.openrc" ${PN}
	systemd_dounit "${FILESDIR}/dogecoind.service"

	keepdir /var/lib/dogecoin/.dogecoin
	fperms 700 /var/lib/dogecoin
	fowners dogecoin:dogecoin /var/lib/dogecoin/
	fowners dogecoin:dogecoin /var/lib/dogecoin/.dogecoin
	dosym /etc/dogecoin/dogecoin.conf /var/lib/dogecoin/.dogecoin/dogecoin.conf

	dodoc doc/README.md doc/release-notes/RELEASE_NOTES_1_8.1.md
	dodoc doc/tor.md
	doman contrib/debian/manpages/dogecoind.1
	doman contrib/debian/manpages/dogecoin.conf.5

	newbashcomp contrib/dogecoind.bash-completion ${PN}

	if use examples; then
		docinto examples
		dodoc -r contrib/{bitrpc,qos,spendfrom,tidy_datadir.sh}
	fi

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/dogecoind.logrotate" dogecoind
	fi
}

pkg_postinst() {
	local v
	for v in ${REPLACING_VERSIONS}; do
		if ! version_is_at_least 1.10.0 ${v}; then
			ewarn "The block database format has changed."
			ewarn "You need to re-index once, by starting with the -reindex parameter."
			ewarn "Add it to DOGECOIND_OPTS in /etc/conf.d/dogecoin.conf"
		fi
		if ! version_compare 1.8.2 ${v}; then
			ewarn "Berkeley DB has been downgraded from 5.1 to 4.8."
			ewarn "To downgrade your wallet, stop your client and run this before restarting:"
			ewarn
			ewarn "$ mv wallet.dat wallet.dat.db51"
			ewarn "$ db5.1_dump wallet.dat.db51 | db4.8_load wallet.dat"
			ewarn
			ewarn "You can now start your client again."
		fi
	done
}
