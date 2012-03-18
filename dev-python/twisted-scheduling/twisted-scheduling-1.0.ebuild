# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twistedsnmp/twistedsnmp-0.3.13.ebuild,v 1.2 2009/11/28 18:14:10 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="twisted.scheduling"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="SNMP protocols and APIs for use with the Twisted networking framework"
HOMEPAGE="http://code.google.com/p/meercat/"
SRC_URI="http://pypi.python.org/packages/source/t/twisted.scheduling/twisted.scheduling-1.0.tar.gz"


LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-python/twisted-1.3"
DEPEND="${RDEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

}

src_install() {
	distutils_src_install
}
