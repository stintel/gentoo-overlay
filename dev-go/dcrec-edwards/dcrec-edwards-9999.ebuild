# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrd/dcrec/edwards"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="Implementation of edwards elliptic curve cryptography needed for Decred"
HOMEPAGE="https://github.com/decred/dcrd/tree/master/dcrec/edwards"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="
	dev-go/dcr-ed25519
	dev-go/fastsha256"
RDEPEND=""
