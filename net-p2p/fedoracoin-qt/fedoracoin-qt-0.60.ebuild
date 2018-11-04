# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DB_VER="4.8"

inherit db-use eutils fdo-mime qmake-utils xdg

MyPV="${PV/_/-}"
MyPN="fedoracoin"
MyP="${MyPN}-${MyPV}"

DESCRIPTION="FedoraCoin (TIPS) crypto currency wallet"
HOMEPAGE="https://fedoracoin.com/"
SRC_URI="https://github.com/${MyPN}/${MyPN}/archive/${MyPV}.tar.gz -> ${MyP}.tar.gz"

LICENSE="MIT ISC GPL-3 LGPL-2.1 public-domain || ( CC-BY-SA-3.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus ipv6 kde +qrcode upnp"

RDEPEND="
	dev-libs/boost[threads(+)]
	dev-libs/openssl:0[-bindist]
	qrcode? (
		media-gfx/qrencode
	)
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	dev-qt/qtgui:5
	dbus? (
		dev-qt/qtdbus:5
	)
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
"

DOCS="doc/README.md doc/release-notes.md"

S="${WORKDIR}/${MyP}"

src_prepare() {
	eapply "${FILESDIR}/miniupnpc-14.patch"

	sed 's/BDB_INCLUDE_PATH=.*//' -i 'fedoracoin-qt.pro'

	cd src || die

	default
}

src_configure() {
	OPTS=()

	use dbus && OPTS+=("USE_DBUS=1")
	if use upnp; then
		OPTS+=("USE_UPNP=1")
	else
		OPTS+=("USE_UPNP=-")
	fi

	use qrcode && OPTS+=("USE_QRCODE=1")
	use ipv6 || OPTS+=("USE_IPV6=-")

	OPTS+=("USE_SYSTEM_LEVELDB=1")
	OPTS+=("BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")")
	OPTS+=("BDB_LIB_SUFFIX=-${DB_VER}")

	if has_version '>=dev-libs/boost-1.52'; then
		OPTS+=("LIBS+=-lboost_chrono\$\$BOOST_LIB_SUFFIX")
	fi

	#The litecoin codebase is mostly taken from bitcoin-qt
	eqmake5 fedoracoin-qt.pro "${OPTS[@]}"
}

#Tests are broken with and without our litecoin-sys_leveldb.patch
#src_test() {
#	cd src || die
#	emake -f makefile.unix "${OPTS[@]}" test_litecoin
#	./test_litecoin || die 'Tests failed'
#}

src_install() {
	dobin ${PN}

	insinto /usr/share/pixmaps
	newins "share/pixmaps/bitcoin.ico" "${PN}.ico"

	make_desktop_entry "${PN} %u" "Fedoracoin-Qt" "/usr/share/pixmaps/${PN}.ico" "Qt;Network;P2P;Office;Finance;" "MimeType=x-scheme-handler/fedoracoin;\nTerminal=false"

#	newman contrib/debian/manpages/bitcoin-qt.1 ${PN}.1
}
