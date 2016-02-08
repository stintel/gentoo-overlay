# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrutil"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="Provides decred-specific convenience functions and types "
HOMEPAGE="https://github.com/decred/dcrutil"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="
	dev-go/btcsuite-ripemd160
	dev-go/dcrd-chaincfg
	dev-go/dcrd-wire
	dev-go/dcrec-edwards
	dev-go/dcrec-secp256k1
	dev-go/dcr-blake256"
RDEPEND=""
