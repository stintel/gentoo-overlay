# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/fedoracoind/fedoracoind-0.7.2.ebuild,v 1.2 2013/01/08 02:13:58 blueness Exp $

EAPI="4"

DB_VER="4.8"

inherit db-use eutils versionator toolchain-funcs user

DESCRIPTION="Fedoracoin crypto-currency wallet for automated services"
HOMEPAGE="http://fedoracoin.org/"

case ${PV} in
9999)
	KEYWORDS=""
	inherit git-2
	EGIT_REPO_URI="git://github.com/fedoracoin/fedoracoin.git"
	;;
*)
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/fedoracoin/fedoracoin/archive/${PV/_/}.tar.gz -> fedoracoin-${PV}.tgz"
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

S="${WORKDIR}/${P/coind/coin}"

pkg_setup() {
	local UG='fedoracoin'
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/fedoracoin "${UG}"
}

src_compile() {
	OPTS=()

	OPTS+=("DEBUGFLAGS=")
	OPTS+=("CXXFLAGS=${CXXFLAGS}")
	OPTS+=("LDFLAGS=${LDFLAGS} -lboost_chrono")

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
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" -f makefile.unix "${OPTS[@]}" test_fedoracoin
	./test_fedoracoin || die 'Tests failed'
}

src_install() {
	dobin src/${PN}

	insinto /etc/fedoracoin
	newins "${FILESDIR}/fedoracoin.conf" fedoracoin.conf
	fowners fedoracoin:fedoracoin /etc/fedoracoin/fedoracoin.conf
	fperms 600 /etc/fedoracoin/fedoracoin.conf

	newconfd "${FILESDIR}/fedoracoin.confd" ${PN}
	newinitd "${FILESDIR}/fedoracoin.initd" ${PN}

	keepdir /var/lib/fedoracoin/.fedoracoin
	fperms 700 /var/lib/fedoracoin
	fowners fedoracoin:fedoracoin /var/lib/fedoracoin/
	fowners fedoracoin:fedoracoin /var/lib/fedoracoin/.fedoracoin
	dosym /etc/fedoracoin/fedoracoin.conf /var/lib/fedoracoin/.fedoracoin/fedoracoin.conf

	dodoc doc/README.md

	if use examples; then
		docinto examples
		dodoc -r contrib/{bitrpc,pyminer,wallettools}
	fi

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/fedoracoind.logrotate" fedoracoind
	fi
}
