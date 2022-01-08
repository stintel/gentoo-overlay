# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="https://core.telegram.org/tdlib"
#SRC_URI="https://github.com/tdlib/td/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
COMMIT_HASH="7d41d9eaa58a6e0927806283252dc9e74eda5512"
SRC_URI="https://github.com/tdlib/td/archive/${COMMIT_HASH}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="jni lto"

DEPEND="dev-libs/openssl
		sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/php
		dev-util/gperf"

S="${WORKDIR}/td-${COMMIT_HASH}"

src_configure() {
	local mycmakeargs=(
		-DTD_ENABLE_DOTNET=no
		-DTD_ENABLE_JNI=$(usex jni)
		-DTD_ENABLE_LTO=$(usex lto)
	)
	cmake_src_configure
}
