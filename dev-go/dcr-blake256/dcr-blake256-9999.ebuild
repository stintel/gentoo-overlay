# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/blake256"

if [[ ${PV} = *9999* ]]; then
        inherit golang-vcs
else
        die
fi
inherit golang-build

DESCRIPTION="Go package blake256 implements BLAKE-256 and BLAKE-224 hash functions"
HOMEPAGE="https://github.com/decred/blake256"
LICENSE="public-domain"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="dev-go/dcr-ed25519"
RDEPEND=""
