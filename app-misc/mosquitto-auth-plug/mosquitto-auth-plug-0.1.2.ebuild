# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit flag-o-matic

DESCRIPTION="Authentication plugin for Mosquitto with multiple back-ends"
HOMEPAGE="https://github.com/jpmens/mosquitto-auth-plug"
SRC_URI="https://github.com/jpmens/${PN}/archive/${PV}/${P}.tar.gz"

LICENSE="BSD-1 BSD NEWLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cdb examples files http jwt ldap memcached mongodb mysql postgres redis sqlite"

DEPEND="app-misc/mosquitto
		cdb? ( dev-db/cdb )
		postgres? ( dev-db/postgresql:= )
		sqlite? ( dev-db/sqlite )
		redis? ( dev-libs/hiredis )
		mongodb? ( dev-libs/mongo-c-driver )
		http? ( net-misc/curl )
		jwt? ( net-misc/curl )
		ldap? ( net-nds/openldap )
		mysql? ( virtual/mysql )"
RDEPEND="${DEPEND}"

src_prepare() {
	use cdb || echo "BACKEND_CDB:=no" >> "${S}/config.mk"
	use files || echo "BACKEND_FILES:=no" >> "${S}/config.mk"
	use http || echo "BACKEND_HTTP:=no" >> "${S}/config.mk"
	use jwt || echo  "BACKEND_JWT:=no" >> "${S}/config.mk"
	use ldap || echo "BACKEND_LDAP:=no" >> "${S}/config.mk"
	use memcached || echo "BACKEND_MEMCACHED:=no" >> "${S}/config.mk"
	use mongodb || echo "BACKEND_MONGO:=no" >> "${S}/config.mk"
	use mysql || echo "BACKEND_MYSQL:=no" >> "${S}/config.mk"
	use postgres || echo "BACKEND_POSTGRES:=no" >> "${S}/config.mk"
	use redis || echo "BACKEND_REDIS:=no" >> "${S}/config.mk"
	use sqlite || echo "BACKEND_SQLITE:=no" >> "${S}/config.mk"

	echo "OPENSSLDIR=/usr" >> "${S}/config.mk"

	default
}

src_compile() {
	append-cflags "-fPIC -I/usr/include/openssl"

	emake
}

src_install() {
	dodoc README.md
	newlib.so "${S}/auth-plug.so" "mosquitto-auth-plug.so"

	use examples && dodoc -r "${S}/examples/"
}
