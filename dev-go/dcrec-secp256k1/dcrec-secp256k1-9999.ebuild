# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrd/dcrec/secp256k1"

if [[ ${PV} = *9999* ]]; then
        inherit golang-vcs
else
        die
fi
inherit golang-build

DESCRIPTION="Implementation of secp256k1 elliptic curve cryptography needed for working with Decred"
HOMEPAGE="https://github.com/decred/dcrd/tree/master/dcrec/secp256k1"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND=""
RDEPEND=""
