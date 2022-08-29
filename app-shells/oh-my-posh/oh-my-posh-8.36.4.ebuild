# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module unpacker

go-module_set_globals

DESCRIPTION="A prompt theme engine for any shell."
HOMEPAGE="https://ohmyposh.dev"
SRC_URI="https://github.com/JanDeDobbeleer/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://gentoo.adlevio.net/${P}-deps.tar.zst"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="themes"

DEPEND=""
RDEPEND="${DEPEND} media-fonts/fontawesome"
BDEPEND="dev-go/go-bindata"

src_unpack() {
	unpacker_src_unpack
}

src_compile() {
	pushd src
	go generate || die
	go build || die
	popd
}

src_install() {
	dobin src/oh-my-posh

	use themes && {
		dodir /usr/share/oh-my-posh
		insinto	/usr/share/oh-my-posh
		doins -r themes
	}
}
