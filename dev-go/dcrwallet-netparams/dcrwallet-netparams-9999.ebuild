# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrwallet/netparams"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="Decred wallet netparams"
HOMEPAGE="https://github.com/decred/dcrwallet/tree/master/netparams"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="dev-go/dcrd-chaincfg"
RDEPEND=""
