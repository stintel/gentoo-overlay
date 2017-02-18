# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )
inherit distutils-r1

DESCRIPTION="Django REST framework is a powerful and flexible toolkit for building Web APIs."
HOMEPAGE="http://www.django-rest-framework.org/"
SRC_URI="https://github.com/tomchristie/${PN}/archive/${PV}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/django-1.8[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
