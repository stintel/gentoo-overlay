# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/litecoin-qt/litecoin-qt-0.7.2.ebuild,v 1.3 2013/02/07 22:39:22 ulm Exp $

EAPI=4

DB_VER="4.8"

inherit db-use eutils qt4-r2 versionator

DESCRIPTION="An end-user Qt4 GUI for the Litecoin crypto-currency"
HOMEPAGE="http://litecoin.org/"
SRC_URI="https://github.com/litecoin-project/litecoin/archive/v${PV/_/}.tar.gz -> litecoin-v${PV}.tgz
"

LICENSE="MIT ISC GPL-3 LGPL-2.1 public-domain || ( CC-BY-SA-3.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="$IUSE dbus ipv6 +qrcode upnp"

RDEPEND="
	>=dev-libs/boost-1.41.0[threads(+)]
	dev-libs/openssl[-bindist]
	qrcode? (
		media-gfx/qrencode
	)
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	dev-qt/qtgui:4
	dbus? (
		dev-qt/qtdbus:4
	)
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
"

DOCS="doc/README"

S="${WORKDIR}/${P/-qt/}"

src_prepare() {
	cd src || die

	local filt= yeslang= nolang=

	filt="litecoin_\\(${filt:2}\\)\\.qm"
	sed "/${filt}/d" -i 'qt/litecoin.qrc'
	einfo "Languages -- Enabled:$yeslang -- Disabled:$nolang"
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

	OPTS+=("BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")")
	OPTS+=("BDB_LIB_SUFFIX=-${DB_VER}")

	eqmake4 "${PN}.pro" "${OPTS[@]}"
}

src_compile() {
	# Workaround for bug #440034
	share/genbuild.sh build/build.h

	emake
}

src_test() {
	cd src || die
	emake -f makefile.unix "${OPTS[@]}" test_litecoin
	./test_litecoin || die 'Tests failed'
}

src_install() {
	qt4-r2_src_install
	dobin ${PN}
	insinto /usr/share/pixmaps
	newins "share/pixmaps/bitcoin.ico" "${PN}.ico"
	make_desktop_entry ${PN} "Litecoin-Qt" "/usr/share/pixmaps/bitcoin.ico" "Network;P2P"
}
