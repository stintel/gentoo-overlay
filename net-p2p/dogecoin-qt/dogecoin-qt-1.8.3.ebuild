# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DB_VER="4.8"

LANGS="ach af_ZA ar be_BY bg bs ca ca@valencia ca_ES cmn cs cy da de de_AT el_GR en eo es es_CL es_DO es_MX es_UY et eu_ES fa fa_IR fi fr fr_CA gl gu_IN he hi_IN hr hu id_ID it ja ka kk_KZ ko_KR ky la lt lv_LV ms_MY nb nl pam pl pt_BR pt_PT ro_RO ru sah sk sl_SI sq sr sv th_TH tr uk ur_PK uz@Cyrl vi vi_VN zh_HK zh_CN zh_TW"
inherit autotools db-use eutils fdo-mime gnome2-utils kde4-functions qt4-r2

MyPV="${PV/_/-}"
MyPN="dogecoin"
MyP="${MyPN}-${MyPV}"

DESCRIPTION="P2P Internet currency favored by Shiba Inus worldwide."
HOMEPAGE="https://dogecoin.com/"
SRC_URI="https://github.com/${MyPN}/${MyPN}/archive/v${MyPV}.tar.gz -> ${MyP}.tar.gz"

LICENSE="MIT ISC GPL-3 LGPL-2.1 public-domain || ( CC-BY-SA-3.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus ipv6 kde +qrcode qt4 qt5 upnp"

RDEPEND="
	dev-libs/boost[threads(+)]
	dev-libs/openssl:0[-bindist]
	dbus? (
		qt4? ( dev-qt/qtdbus:4 )
		qt5? ( dev-qt/qtdbus:5 )
	)
	qt4? ( dev-qt/qtgui:4 )
	qt5? ( dev-qt/qtgui:5 dev-qt/qtnetwork:5 dev-qt/qtwidgets:5 )
	qrcode? (
		media-gfx/qrencode
	)
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	virtual/bitcoin-leveldb
"
DEPEND="${RDEPEND}
	qt5? ( dev-qt/linguist-tools:5 )
"
REQUIRED_USE="^^ ( qt4 qt5 )"

DOCS="doc/README.md doc/release-notes.md"

S="${WORKDIR}/${MyP}"

src_prepare() {
	epatch "${FILESDIR}/${MyPN}-1.8.3-sys_leveldb.patch"
	epatch "${FILESDIR}/${MyPN}-1.8.3-bdb48.patch"
	eautoreconf
	rm -r src/leveldb

	cd src || die

	local filt= yeslang= nolang= lan ts x

	for lan in $LANGS; do
		if [ ! -e qt/locale/bitcoin_$lan.ts ]; then
			ewarn "Language '$lan' no longer supported. Ebuild needs update."
		fi
	done

	for ts in qt/locale/*.ts
	do
		x="${ts/*bitcoin_/}"
		x="${x/.ts/}"
		if ! use "linguas_$x"; then
			nolang="$nolang $x"
			rm "$ts"
			filt="$filt\\|$x"
		else
			yeslang="$yeslang $x"
		fi
	done

	filt="bitcoin_\\(${filt:2}\\)\\.\(qm\|ts\)"
	sed "/${filt}/d" -i 'qt/dogecoin.qrc'
	sed "s/locale\/${filt}/dogecoin.qrc/" -i 'qt/Makefile.in' || die
	einfo "Languages -- Enabled:$yeslang -- Disabled:$nolang"
}

src_configure() {
	local my_econf=
	if use upnp; then
		my_econf="${my_econf} --with-miniupnpc --enable-upnp-default"
	else
		my_econf="${my_econf} --without-miniupnpc --disable-upnp-default"
	fi

	econf \
		--enable-wallet \
		--disable-ccache \
		--disable-static \
		--disable-tests \
		--with-system-leveldb \
		--with-system-libsecp256k1  \
		--without-libs \
		--without-utils \
		--without-daemon  \
		--with-gui=$(usex qt5 qt5 qt4) \
		$(use_with dbus qtdbus)  \
		$(use_with qrcode qrencode)  \
		${my_econf}
}

#Tests are broken with and without our litecoin-sys_leveldb.patch
#src_test() {
#	cd src || die
#	emake -f makefile.unix "${OPTS[@]}" test_litecoin
#	./test_litecoin || die 'Tests failed'
#}

src_install() {
#	qt4-r2_src_install

	dobin "src/qt/${PN}"

	insinto /usr/share/pixmaps
	newins "share/pixmaps/bitcoin.ico" "${PN}.ico"

	make_desktop_entry "${PN} %u" "Dogecoin-Qt" "/usr/share/pixmaps/${PN}.ico" "Qt;Network;P2P;Office;Finance;" "MimeType=x-scheme-handler/dogecoin;\nTerminal=false"

#	newman contrib/debian/manpages/bitcoin-qt.1 ${PN}.1

#	if use kde; then
#		insinto /usr/share/kde4/services
#		newins contrib/debian/bitcoin-qt.protocol ${PN}.protocol
#	fi
}

update_caches() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
	buildsycoca
}

pkg_postinst() {
	update_caches
}

pkg_postrm() {
	update_caches
}
