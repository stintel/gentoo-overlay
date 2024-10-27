# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="New libpurple plugin for Telegram"
HOMEPAGE="https://github.com/BenWiederhake/tdlib-purple"
EGIT_REPO_URI="https://github.com/BenWiederhake/tdlib-purple"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="webp"

DEPEND="webp? ( media-libs/libwebp )
		net-im/pidgin
		>=net-libs/tdlib-1.8.35"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=( "${FILESDIR}/${P}-link-zlib.patch" )

src_configure() {
	local mycmakeargs=(
		-DNoVoip=True
		-DNoWebp=$(usex webp false true)
	)
	cmake_src_configure
}
