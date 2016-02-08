# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrd/wire"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="Implementation of the Decred wire protocol"
HOMEPAGE="https://github.com/decred/dcrd/tree/master/wire"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="dev-go/dcr-blake256
		dev-go/dcrd-chainhash"
RDEPEND=""
