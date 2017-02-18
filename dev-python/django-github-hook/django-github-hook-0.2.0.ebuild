# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )
inherit distutils-r1

DESCRIPTION="Configurable post-receive webhook handler, implemented as a Django app"
HOMEPAGE="https://github.com/sheppard/django-github-hook"
SRC_URI="https://github.com/sheppard/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/django-1.8[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
