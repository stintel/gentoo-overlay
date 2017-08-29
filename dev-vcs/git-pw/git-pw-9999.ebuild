# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="A tool for integrating Git with Patchwork, the web-based patch tracking system"
HOMEPAGE="https://github.com/getpatchwork/git-pw"

case ${PV} in
	9999)
		inherit git-r3
		KEYWORDS=""
		EGIT_REPO_URI="https://github.com/getpatchwork/${PN}.git"
		;;
esac

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="dev-python/arrow[${PYTHON_USEDEP}]
		dev-python/click[${PYTHON_USEDEP}]
		dev-python/pbr[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/tabulate[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
