# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1 git-r3

DESCRIPTION="Simple GUI tool to flash ESPs over USB"
HOMEPAGE="https://esphome.io/"
#SRC_URI="https://github.com/esphome/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/stintel/esphome-flasher.git"
EGIT_BRANCH="esp32c3"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND=">=dev-embedded/esptool-2.8"
DEPEND="dev-python/requests
		dev-python/wxpython:4.0"

PATCHES=(
	"${FILESDIR}/${PN}-1.4.0-wxpython-4.0.patch"
)
