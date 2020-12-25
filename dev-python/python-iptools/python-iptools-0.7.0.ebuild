# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

MY_PN="iptools"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Utilites for manipulating IPv4 and IPv6 addresses"
HOMEPAGE="https://pypi.python.org/pypi/iptools"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="dev-python/setuptools"

S="${WORKDIR}/${MY_P}"
