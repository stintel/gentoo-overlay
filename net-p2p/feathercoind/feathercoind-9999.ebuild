# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DB_VER="4.8"

inherit db-use eutils git-2 user versionator

DESCRIPTION="Original Feathercoin crypto-currency wallet for automated services"
HOMEPAGE="http://feathercoin.org/"
SRC_URI="
"
EGIT_PROJECT='feathercoin'
EGIT_REPO_URI="git://github.com/FeatherCoin/FeatherCoin.git"
EGIT_BRANCH='master'

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="examples ipv6 logrotate upnp"

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
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
"

pkg_setup() {
	local UG='feathercoin'
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/feathercoin "${UG}"
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

	cd src || die
	emake -f makefile.unix "${OPTS[@]}" ${PN}
}

src_test() {
	cd src || die
	emake -f makefile.unix "${OPTS[@]}" test_feathercoin
	./test_feathercoin || die 'Tests failed'
}

src_install() {
	dobin src/${PN}

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

	dodoc doc/README

	if use examples; then
		docinto examples
		dodoc -r contrib/{bitrpc,pyminer,wallettools}
	fi

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/feathercoind.logrotate" feathercoind
	fi
}
