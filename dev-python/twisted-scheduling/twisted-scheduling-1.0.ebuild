# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libcloud/libcloud-0.5.2.ebuild,v 1.1 2011/07/25 15:57:56 patrick Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Unified Interface to the Cloud - python support libs"
HOMEPAGE="http://code.google.com/p/meercat/"
#SRC_URI="mirror://apache/${PN}/apache-${P}.tar.bz2"
SRC_URI="http://pypi.python.org/packages/source/t/twisted.scheduling/twisted.scheduling-1.0.tar.gz"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

RDEPEND=""
DEPEND=""

#S="${WORKDIR}/apache-${P}"
