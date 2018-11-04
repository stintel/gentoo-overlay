# Copyright 2010-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DB_VER="4.8"

inherit autotools bash-completion-r1 db-use eutils user versionator systemd

MyPV="${PV/_/}"
MyPN="dogecoin"
MyP="${MyPN}-${MyPV}"

DESCRIPTION="Dogecoin crypto-currency wallet for automated services"
HOMEPAGE="http://dogecoin.org/"

case ${PV} in
9999)
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dogecoin/dogecoin.git"
	;;
*)
	SRC_URI="https://github.com/dogecoin/dogecoin/archive/v${PV/_/}.tar.gz -> dogecoin-v${PV}.tgz"
	S="${WORKDIR}/${MyP}"
esac

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
		--without-libs \
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
