# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9,10} )

inherit distutils-r1

DESCRIPTION="A Nagios-plugin to check HDD temperatures"
HOMEPAGE="https://github.com/vint21h/nagios-check-hddtemp"
SRC_URI="https://github.com/vint21h/nagios-check-hddtemp/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	local nagiosplugindir=/usr/$(get_libdir)/nagios/plugins
	exeinto ${nagiosplugindir}
	newexe check_hddtemp.py check_hddtemp

	dodoc README.rst
}
