# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools flag-o-matic git-r3

DESCRIPTION="a CUDA accelerated cryptocoin mining application"
HOMEPAGE="https://github.com/cbuchner1/CudaMiner"
SRC_URI=""

EGIT_REPO_URI="https://github.com/cbuchner1/CudaMiner.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/jansson
		dev-util/nvidia-cuda-toolkit"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-cuda65-compat.patch"

	eautoreconf
}

src_configure() {
	strip-flags
	filter-flags -ggdb -pipe -m*
	append-ldflags -L/opt/cuda/lib64

	econf
}
