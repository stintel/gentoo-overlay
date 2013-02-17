# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_{6,7})

inherit distutils-r1

MY_PN="TxScheduling"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A scheduling plugin for Twisted"
HOMEPAGE="http://pypi.python.org/pypi/TxScheduling"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/twisted-1.3"

S="${WORKDIR}/${MY_P}"
