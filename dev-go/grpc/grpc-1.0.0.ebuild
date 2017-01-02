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
	SRC_URI="https://github.com/grpc/grpc-go/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="The Go language implementation of gRPC. HTTP/2 based RPC"
HOMEPAGE="https://google.golang.org/grpc"
LICENSE="ISC"
SLOT="0/${PVR}"
IUSE=""
RESTRICT="test"
DEPEND="
	dev-go/go-glog:0
	dev-go/go-oauth2:0
	dev-go/go-net:0
	dev-go/go-protobuf:0"
RDEPEND=""