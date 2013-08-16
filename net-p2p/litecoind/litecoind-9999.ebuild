# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/litecoind/litecoind-0.7.2.ebuild,v 1.2 2013/01/08 02:13:58 blueness Exp $

EAPI="4"

DB_VER="4.8"

inherit db-use eutils versionator toolchain-funcs

DESCRIPTION="Litecoin crypto-currency wallet for automated services"
HOMEPAGE="http://litecoin.org/"

case ${PV} in
9999)
	inherit git-2
	EGIT_REPO_URI="git://github.com/litecoin-project/litecoin.git"
	;;
*)
	SRC_URI="https://github.com/litecoin-project/litecoin/archive/v${PV/_/}.tar.gz -> litecoin-v${PV}.tgz"
esac

LICENSE="MIT ISC GPL-2"
SLOT="0"
IUSE="examples ipv6 logrotate upnp"

RDEPEND="
	>=dev-libs/boost-1.41.0[threads(+)]
	dev-libs/openssl[-bindist]
	logrotate? (
		app-admin/logrotate
	)
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
"

S="${WORKDIR}/${P/d/}"

pkg_setup() {
	local UG='litecoin'
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/litecoin "${UG}"
}

src_compile() {
	OPTS=()

	OPTS+=("DEBUGFLAGS=")
	OPTS+=("CXXFLAGS=${CXXFLAGS}")
	OPTS+=("LDFLAGS=${LDFLAGS}")

	OPTS+=("BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")")
	OPTS+=("BDB_LIB_SUFFIX=-${DB_VER}")

	if use upnp; then
		OPTS+=(USE_UPNP=1)
	else
		OPTS+=(USE_UPNP=)
	fi
	use ipv6 || OPTS+=("USE_IPV6=-")

	# Workaround for bug #440034
	share/genbuild.sh src/obj/build.h

	cd src || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" -f makefile.unix "${OPTS[@]}" ${PN}
}

src_test() {
	cd src || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" -f makefile.unix "${OPTS[@]}" test_litecoin
	./test_litecoin || die 'Tests failed'
}

src_install() {
	dobin src/${PN}

	insinto /etc/litecoin
	newins "${FILESDIR}/litecoin.conf" litecoin.conf
	fowners litecoin:litecoin /etc/litecoin/litecoin.conf
	fperms 600 /etc/litecoin/litecoin.conf

	newconfd "${FILESDIR}/litecoin.confd" ${PN}
	newinitd "${FILESDIR}/litecoin.initd" ${PN}

	keepdir /var/lib/litecoin/.litecoin
	fperms 700 /var/lib/litecoin
	fowners litecoin:litecoin /var/lib/litecoin/
	fowners litecoin:litecoin /var/lib/litecoin/.litecoin
	dosym /etc/litecoin/litecoin.conf /var/lib/litecoin/.litecoin/litecoin.conf

	dodoc doc/README

	if use examples; then
		docinto examples
		dodoc -r contrib/{bitrpc,pyminer,wallettools}
	fi

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/litecoind.logrotate" litecoind
	fi
}
