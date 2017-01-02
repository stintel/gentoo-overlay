# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_SRC="google.golang.org/grpc"
EGO_PN=${EGO_SRC}/...

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64"
	EGIT_COMMIT="b1097423a0b9330bca6814ab392234fbfad2f406"
	SRC_URI="https://github.com/grpc/grpc-go/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Provides decred-specific convenience functions and types "
HOMEPAGE="https://google.golang.org/grpc"
LICENSE="ISC"
SLOT="0/${PVR}"
IUSE=""
RESTRICT="test"
DEPEND="
	dev-go/go-net:0/${PVR}
	dev-go/go-protobuf:0/${PVR}"
RDEPEND=""
