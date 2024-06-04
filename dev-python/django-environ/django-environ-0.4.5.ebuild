# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{8,9,10,11,12} )
inherit distutils-r1 pypi

DESCRIPTION="12factor inspired environment variables for your Django project"
HOMEPAGE="https://github.com/joke2k/django-environ"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-python/django-1.8[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
