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
inherit golang-build

DESCRIPTION="A secure decred wallet daemon written in Go"
HOMEPAGE="https://github.com/decred/dcrwallet"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="
	dev-db/bolt
	dev-go/btcd-wire
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

src_install() {
	exeinto /usr/bin
	doexe "${S}/dcrwallet"
	dodoc -r "${S}/src/${EGO_PN}/docs/"
}
