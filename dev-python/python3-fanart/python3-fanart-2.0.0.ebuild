# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Python interface to fanart.tv API"
HOMEPAGE="https://github.com/opacam/python3-fanart"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/requests"
DEPEND=""
