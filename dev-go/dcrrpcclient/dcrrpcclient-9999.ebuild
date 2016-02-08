# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrrpcclient"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="A robust and easy to use websocket-enabled Decred JSON-RPC client."
HOMEPAGE="https://github.com/decred/dcrrpcclient"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="
	dev-go/btclog
	dev-go/btcsuite-socks
	dev-go/btcsuite-websocket
	dev-go/dcrd-chainhash
	dev-go/dcrd-dcrjson
	dev-go/dcrd-wire
	dev-go/dcrutil"
RDEPEND=""
