# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"
MY_P="${P/-agent/}"
MY_P="${MY_P/_p/p}"
S="${WORKDIR}/${MY_P}"

inherit python toolchain-funcs

DESCRIPTION="Nagios check_mk host agent"
HOMEPAGE="http://mathias-kettner.de/check_mk.html"
SRC_URI="http://mathias-kettner.de/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${DEPEND}
	sys-apps/xinetd"

doit() {
	echo "$@"
	$@ || die Failed.
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	unpack ./agents.tar.gz
}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_compile() {
	doit $(tc-getCC) ${CFLAGS} waitmax.c -o waitmax
}

src_install() {
	newbin check_mk_agent.linux check_mk_agent

	insinto "/usr/lib/check_mk_agent"
	doins waitmax

	keepdir /usr/lib/check_mk_agent/local
	keepdir /usr/lib/check_mk_agent/plugins

	dodoc AUTHORS ChangeLog

	insinto /etc/xinetd.d
	newins xinetd.conf check_mk
}
