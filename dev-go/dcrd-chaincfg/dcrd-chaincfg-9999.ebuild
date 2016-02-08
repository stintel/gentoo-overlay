# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrd/chaincfg"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="Chain configuration parameters for the three standard Decred networks"
HOMEPAGE="https://github.com/decred/dcrd/tree/master/chaincfg"
LICENSE="MIT"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="
	dev-go/dcr-blake256
	dev-go/dcrd-wire"
RDEPEND=""

src_install()
{
	# avoid file collisions with dcrd-chainhash
	golang-build_src_install
	rm -r "${D}/usr/lib/go-gentoo/pkg/linux_${ARCH}/${EGO_PN}/chainhash.a"
	rm -r "${D}/usr/lib/go-gentoo/src/${EGO_PN}/chainhash"
}
