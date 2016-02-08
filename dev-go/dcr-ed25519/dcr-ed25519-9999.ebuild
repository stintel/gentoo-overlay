# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/ed25519"

if [[ ${PV} = *9999* ]]; then
        inherit golang-vcs
else
        die
fi
inherit golang-build

DESCRIPTION="Decred fork of ed25519 for Go"
HOMEPAGE="https://github.com/decred/ed25519"
LICENSE="BSD"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND=""
RDEPEND=""
