# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="New libpurple plugin for Telegram"
HOMEPAGE="https://github.com/ars3niy/tdlib-purple"
SRC_URI="https://github.com/ars3niy/tdlib-purple/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="net-im/pidgin
		~net-libs/tdlib-1.7.9"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=( -DNoVoip=True )
	cmake_src_configure
}
