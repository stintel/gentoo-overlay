# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

PV_COMMIT="8d08b34e22a08e58db8341839c4e18ee06c516c5"

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="https://core.telegram.org/tdlib"
SRC_URI="https://github.com/tdlib/td/archive/${PV_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/td-${PV_COMMIT}"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="jni lto"

DEPEND="dev-libs/openssl
		sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/php
		dev-util/gperf"

src_configure() {
	local mycmakeargs=(
		-DTD_ENABLE_DOTNET=no
		-DTD_ENABLE_JNI=$(usex jni)
		-DTD_ENABLE_LTO=$(usex lto)
	)
	cmake_src_configure
}
