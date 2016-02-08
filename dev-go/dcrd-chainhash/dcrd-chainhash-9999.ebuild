# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrd/chaincfg/chainhash"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="A wrapper around the hash function used for decred"
HOMEPAGE="https://github.com/decred/dcrd/tree/master/chaincfg/chainhash"
LICENSE="MIT"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="dev-go/dcr-blake256"
RDEPEND=""
