# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Opensource XenServer Management Interface"
HOMEPAGE="https://github.com/OpenXenManager/openxenmanager"

EGIT_REPO_URI="https://github.com/OpenXenManager/openxenmanager.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/configobj[${PYTHON_USEDEP}]
		dev-python/pygtk[${PYTHON_USEDEP}]
		net-libs/gtk-vnc[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
