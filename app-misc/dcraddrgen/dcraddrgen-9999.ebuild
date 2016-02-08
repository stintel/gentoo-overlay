# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
EGO_PN="github.com/decred/${PN}"

inherit golang-vcs golang-build

DESCRIPTION="dcraddrgen is a simple offline address generator for decred"
HOMEPAGE="https://decred.org/"

LICENSE="ISC"
SLOT="0"
IUSE=""

DEPEND="
	dev-go/btcec
	dev-go/btcd-wire
	dev-go/btcsuite-ripemd160
	dev-go/dcr-blake256"
RDEPEND=""
