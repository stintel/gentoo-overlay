# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Improved Python wrapper around the free UnRAR.dll"
HOMEPAGE="http://pypi.python.org/pypi/pyUnRAR2"
SRC_URI="https://github.com/yk4ever/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND=""
