# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..14} )

inherit distutils-r1 pypi

DESCRIPTION="Amlogic SoC USB Boot utility"
HOMEPAGE="https://github.com/superna9999/pyamlboot"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="$(python_gen_cond_dep '
			dev-python/pyusb[${PYTHON_USEDEP}]
			dev-python/setuptools[${PYTHON_USEDEP}]
		')"
RDEPEND="${DEPEND}"
