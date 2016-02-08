# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrd/blockchain"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="A library implenenting decred block handling and chain selection rules"
HOMEPAGE="https://github.com/decred/dcrd/tree/master/blockchain"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="
	dev-go/btclog
	dev-go/dcrd-database
	dev-go/dcrd-chaincfg
	dev-go/dcrd-chainhash
	dev-go/dcrd-wire
	dev-go/dcrd-txscript
	dev-go/dcrutil"
RDEPEND=""
