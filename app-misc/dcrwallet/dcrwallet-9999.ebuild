# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrwallet"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build systemd user

DESCRIPTION="A secure decred wallet daemon written in Go"
HOMEPAGE="https://github.com/decred/dcrwallet"
LICENSE="ISC"
SLOT="0"
IUSE="systemd"
RESTRICT="test"
DEPEND="
	dev-db/bolt
	dev-go/bitset
	dev-go/btclog
	dev-go/btcsuite-ripemd160
	dev-go/btcsuite-scrypt
	dev-go/btcsuite-secretbox
	dev-go/btcsuite-seelog
	dev-go/btcsuite-terminal
	dev-go/btcsuite-websocket
	dev-go/dcrd-blockchain
	dev-go/dcrd-chaincfg
	dev-go/dcrd-chainhash
	dev-go/dcrd-dcrjson
	dev-go/dcrd-txscript
	dev-go/dcrd-wire
	dev-go/dcrrpcclient
	dev-go/dcrutil
	dev-go/go-flags
	dev-go/go-net
	dev-go/grpc"
RDEPEND=""

PUSER="decred"
PUG="${PUSER}:${PUSER}"
PHOME="/var/lib/${PUSER}"
PCONFDIR="/etc/decred"
PCONFFILE="${PCONFDIR}/dcrwallet.conf"

pkg_setup() {
	enewgroup "${PUSER}"
	enewuser "${PUSER}" -1 -1 "${PHOME}" "${PUSER}"
}

src_install() {
	exeinto /usr/bin
	doexe "${S}/dcrwallet"
	dodoc -r "${S}/src/${EGO_PN}/docs/"

	insinto "${PCONFDIR}"
	newins "${S}/src/${EGO_PN}/sample-dcrwallet.conf" dcrwallet.conf
	fowners "${PUG}" "${PCONFFILE}"
	fperms 600 "${PCONFFILE}"

	keepdir "${PHOME}"/.dcrwallet
	fperms 700 "${PHOME}"
	fowners "${PUG}" "${PHOME}"
	fowners "${PUG}" "${PHOME}"/.dcrwallet
	dosym "${PCONFFILE}" "${PHOME}"/.dcrwallet/dcrwallet.conf

	if use systemd; then
		systemd_dounit "${FILESDIR}/${PN}.service"
	fi
}
