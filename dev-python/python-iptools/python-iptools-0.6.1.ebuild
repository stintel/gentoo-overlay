# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1

MY_PN="iptools"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Utilites for manipulating IPv4 and IPv6 addresses"
HOMEPAGE="http://pypi.python.org/pypi/iptools"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
