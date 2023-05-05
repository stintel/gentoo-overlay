# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9,10,11} )
inherit distutils-r1

DESCRIPTION="Configurable post-receive webhook handler, implemented as a Django app"
HOMEPAGE="https://github.com/sheppard/django-github-hook"
SRC_URI="https://github.com/sheppard/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-python/django-1.8[${PYTHON_USEDEP}]
		dev-python/djangorestframework[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
