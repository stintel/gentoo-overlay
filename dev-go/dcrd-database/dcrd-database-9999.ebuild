# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrd/database"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="Provides a database interface for the decred block chain and transactions."
HOMEPAGE="https://github.com/decred/dcrd/tree/master/database"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="
	dev-go/btclog
	dev-go/dcrd-chainhash
	dev-go/dcrd-wire
	dev-go/dcrutil"
RDEPEND=""
