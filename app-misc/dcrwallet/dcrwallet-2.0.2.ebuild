# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module systemd

go-module_set_globals

DESCRIPTION="dcrwallet"
HOMEPAGE="https://github.com/decred/dcrwallet"
SRC_URI="https://github.com/decred/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://gentoo.adlevio.net/${P}-deps.tar.xz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

DEPEND=""
RDEPEND="app-misc/dcrctl"

PUSER="decred"
PUG="${PUSER}:${PUSER}"
PHOME="/var/lib/${PUSER}"
PCONFDIR="/etc/decred"
PCONFFILE="${PCONFDIR}/dcrwallet.conf"

src_compile() {
	go build || die
}

src_install() {
	dobin dcrwallet

	dodoc -r "${S}/docs/"

	insinto "${PCONFDIR}"
	newins "${S}/sample-dcrwallet.conf" dcrwallet.conf
	fowners "${PUG}" "${PCONFFILE}"
	fperms 600 "${PCONFFILE}"

	keepdir "${PHOME}"/.dcrwallet
	fperms 700 "${PHOME}"
	fowners "${PUG}" "${PHOME}"
	fowners "${PUG}" "${PHOME}"/.dcrwallet
	dosym "${PCONFFILE}" "${PHOME}"/.dcrwallet/dcrwallet.conf

	if use systemd; then
		systemd_dounit "${FILESDIR}/${PN}.service"
		systemd_newuserunit "${FILESDIR}/${PN}.service.user" "${PN}.service"
	fi
}
