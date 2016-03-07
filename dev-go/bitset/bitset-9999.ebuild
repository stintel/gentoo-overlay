# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/bitset"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="Bitset implementations for Go"
HOMEPAGE="https://github.com/decred/bitset"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND=""
RDEPEND=""
