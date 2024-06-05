# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=setuptools
PYPI_PN=iptools
PYTHON_COMPAT=( python3_{8..12} )

inherit distutils-r1 pypi

MY_PN="iptools"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Utilites for manipulating IPv4 and IPv6 addresses"
HOMEPAGE="https://pypi.python.org/pypi/iptools"

S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools"

