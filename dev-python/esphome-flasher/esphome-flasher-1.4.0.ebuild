# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1

DESCRIPTION="Simple GUI tool to flash ESPs over USB"
HOMEPAGE="https://esphome.io/"
SRC_URI="https://github.com/esphome/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-embedded/esptool-2.8"
DEPEND="dev-python/requests
		dev-python/wxpython:4.0"

PATCHES=(
	"${FILESDIR}/${P}-wxpython-4.0.patch"
)
