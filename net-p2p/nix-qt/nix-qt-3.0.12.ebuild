# Copyright 2010-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DB_VER="4.8"
inherit autotools bash-completion-r1 db-use flag-o-matic gnome2-utils xdg-utils

MyPV="${PV/_/-}"
MyPN="NixCore"
MyP="${MyPN}-${MyPV}"

DESCRIPTION="An end-user Qt GUI for the NIX crypto-currency"
HOMEPAGE="https://nixplatform.io/"
SRC_URI="https://github.com/NIXPlatform/${MyPN}/archive/v${MyPV}.tar.gz -> ${MyP}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"

IUSE="+asm dbus kde libressl +qrcode +system-leveldb test upnp +wallet zeromq"
RESTRICT="!test? ( test )"

RDEPEND="
	app-crypt/libscrypt
	>=dev-libs/boost-1.52.0:=[threads(+)]
	>=dev-libs/libsecp256k1-0.0.0_pre20151118:=[recovery]
	dev-libs/protobuf:=
	>=dev-libs/univalue-1.0.4:=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	system-leveldb? ( virtual/bitcoin-leveldb )
	dbus? ( dev-qt/qtdbus:5 )
	dev-libs/libevent:=
	!libressl? ( dev-libs/openssl:0=[-bindist] )
	libressl? ( dev-libs/libressl:0= )
	qrcode? (
		media-gfx/qrencode:=
	)
	upnp? ( >=net-libs/miniupnpc-1.9.20150916:= )
	wallet? ( sys-libs/db:$(db_ver_to_slot "${DB_VER}")=[cxx] )
	zeromq? ( net-libs/zeromq:= )
"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5
"

DOCS=( doc/bips.md doc/files.md doc/reduce-traffic.md doc/release-notes.md doc/REST-interface.md doc/tor.md )

S="${WORKDIR}/${MyP}"

src_prepare() {
	for dir in . src/{secp256k1,tor}; do
		pushd $dir
		eautoreconf
		popd
	done

	sed -i 's/^\(complete -F _nixd \)nixd \(nix-qt\)$/\1\2/' contrib/nixd.bash-completion || die

	eapply "${FILESDIR}"/${P}-boost-1.72-missing-include.patch
	eapply "${FILESDIR}"/${P}-boost-1.73.0.patch
	eapply "${FILESDIR}"/${P}-qt-5.15.patch
	eapply "${FILESDIR}"/${P}-sys_leveldb.patch

	eapply_user

	echo '#!/bin/true' >share/genbuild.sh || die
	mkdir -p src/obj || die
	echo "#define BUILD_SUFFIX gentoo${PVR#${PV}}" >src/obj/build.h || die

	eautoreconf
	if use system-leveldb; then
		rm -r src/leveldb || die
	fi
}

src_configure() {
	append-ldflags -lscrypt

	local my_econf=(
		$(use_enable asm)
		$(use_with dbus qtdbus)
		$(use_with qrcode qrencode)
		$(use_with upnp miniupnpc)
		$(use_enable upnp upnp-default)
		$(use_enable test tests)
		$(use_enable wallet)
		$(use_enable zeromq zmq)
		--with-gui=qt5
		--disable-util-cli
		--disable-util-tx
		--disable-bench
		--without-libs
		--without-daemon
		--disable-ccache
		--disable-static
		$(use_with system-leveldb)
		--with-system-libsecp256k1
		--with-system-univalue
	)
	econf "${my_econf[@]}"
}

src_install() {
	default

	rm -f "${ED%/}/usr/bin/test_bitcoin" || die

	insinto /usr/share/applications
	doins "contrib/debian/nix-qt.desktop"

	use zeromq && dodoc doc/zmq.md

	newbashcomp contrib/nixd.bash-completion ${PN}

	if use kde; then
		insinto /usr/share/kservices5
		doins "contrib/debian/nix-qt.protocol"
		dosym "../../kservices5/nix-qt.protocol" "/usr/share/kde4/services/nix-qt.protocol"
	fi
}

update_caches() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	update_caches
}

pkg_postrm() {
	update_caches
}
