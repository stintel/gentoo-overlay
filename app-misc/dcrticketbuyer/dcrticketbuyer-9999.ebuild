# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrticketbuyer"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="An automated smart ticket purchaser"
HOMEPAGE="https://github.com/decred/dcrticketbuyer"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="dev-go/btclog
		dev-go/btcsuite-flags
		dev-go/btcsuite-seelog
		dev-go/dcrd-chainhash
		dev-go/dcrd-dcrjson
		dev-go/dcrrpcclient
		dev-go/dcrutil"
RDEPEND=""

src_install() {
	exeinto /usr/bin
	doexe "${S}/dcrticketbuyer"
}
