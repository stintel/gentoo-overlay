# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrd/cmd/dcrctl"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="dcrctl"
HOMEPAGE="https://github.com/decred/dcrd/tree/master/cmd/dcrctl"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="
	dev-go/btcsuite-flags
	dev-go/btcsuite-socks
	dev-go/dcrd-dcrjson
	dev-go/dcrutil
	dev-go/go-crypto"
RDEPEND=""

golang_install_pkgs() {
	debug-print-function ${FUNCNAME} "$@"

	ego_pn_check
	insinto "$(get_golibdir)"
	insopts -m0644 -p # preserve timestamps for bug 551486
	doins -r src
}

src_install() {
	golang-build_src_install
	dobin bin/*
}
