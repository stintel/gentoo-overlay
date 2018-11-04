# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python{2_7,3_{4,5,6}})

MyPV="${PV/_rc/rc}"

inherit distutils-r1

DESCRIPTION="The tool for updating your Suricata rules."
HOMEPAGE="https://github.com/OISF/suricata-update"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${MyPV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/python-dateutil
		dev-python/pyyaml
		dev-python/sphinx
		dev-python/sphinxcontrib-programoutput"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MyPV}"
