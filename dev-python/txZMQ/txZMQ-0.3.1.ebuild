# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Twisted bindings for ZeroMQ"
HOMEPAGE="http://pypi.python.org/pypi/txZMQ"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=""
DEPEND=""

#S="${WORKDIR}/apache-${P}"
