# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrd"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build user systemd

DESCRIPTION="An alternative full node dcrd implementation written in Go (golang)"
HOMEPAGE="https://github.com/decred/dcrd/blob/master/README.md"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="
	dev-go/bitset
	dev-go/btclog
	dev-go/btcsuite-flags
	dev-go/btcsuite-socks
	dev-go/btcsuite-leveldb
	dev-go/btcsuite-seelog
	dev-go/btcsuite-websocket
	dev-go/dcrutil
	dev-go/go-protobuf
	dev-go/go-spew
	dev-go/grpc"
RDEPEND=""

PUSER="dcrd"
PUG="${PUSER}:${PUSER}"
PHOME="/var/lib/${PUSER}"
PCONFDIR="/etc/dcrd"
PCONFFILE="${PCONFDIR}/dcrd.conf"

pkg_setup() {
	enewgroup "${PUSER}"
	enewuser "${PUSER}" -1 -1 "${PHOME}" "${PUSER}"
}

src_install() {
	exeinto /usr/bin
	doexe "${S}/dcrd"
	dodoc -r "${S}/src/${EGO_PN}/docs"

	insinto "${PCONFDIR}"
	newins "${FILESDIR}/dcrd.conf" dcrd.conf
	fowners "${PUG}" "${PCONFFILE}"
	fperms 600 "${PCONFFILE}"

	systemd_dounit "${FILESDIR}/dcrd.service"

	keepdir "${PHOME}"/.dcrd
	fperms 700 "${PHOME}"
	fowners "${PUG}" "${PHOME}"
	fowners "${PUG}" "${PHOME}"/.dcrd
	dosym "${PCONFFILE}" "${PHOME}"/.dcrd/dcrd.conf

}
