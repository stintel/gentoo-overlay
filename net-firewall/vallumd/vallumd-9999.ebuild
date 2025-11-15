# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [ "${PV}" = 9999 ]; then
	inherit git-r3
	EGIT_BRANCH="nft"
	EGIT_REPO_URI="https://codeberg.org/stintel/vallumd.git"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://codeberg.org/stintel/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}"
fi

DESCRIPTION="Centralize or distribute IP blacklists"
HOMEPAGE="https://codeberg.org/stintel/vallumd"

LICENSE="GPL-3"
SLOT="0"
IUSE="+ipset nftables"
REQUIRED_USE="^^ ( ipset nftables )"

DEPEND="app-misc/mosquitto
		ipset? ( net-firewall/ipset )
		nftables? ( net-libs/libnftnl )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DUSE_BACKEND=$(usex ipset ipset nftables)
	)
	cmake_src_configure
}
