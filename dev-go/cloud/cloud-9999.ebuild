# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="google.golang.org/cloud"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="Go on Google Cloud Platform"
HOMEPAGE="https://cloud.google.com/go/home"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND=""
RDEPEND=""
