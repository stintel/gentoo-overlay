# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="OP-TEE Client"
HOMEPAGE="https://optee.readthedocs.io/en/latest/"
SRC_URI="https://github.com/OP-TEE/optee_client/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~arm64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DCFG_USE_PKGCONFIG=ON
	)
	cmake_src_configure
}
