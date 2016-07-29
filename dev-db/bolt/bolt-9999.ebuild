# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/boltdb/bolt"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="An embedded key/value database for Go."
HOMEPAGE="https://github.com/boltdb/bolt"
LICENSE="MIT"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND=""
RDEPEND=""
