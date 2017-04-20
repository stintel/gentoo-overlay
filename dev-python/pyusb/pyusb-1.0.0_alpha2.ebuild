# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_P="${P/_alpha/a}"
MY_V="${MY_P/${PN}-}"

DESCRIPTION="USB support for Python."
HOMEPAGE="http://pyusb.sourceforge.net/"
SRC_URI="https://github.com/walac/pyusb/tarball/${MY_V} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

### This version is compatible with both 0.X and 1.X versions of libusb
DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_V}"

PYTHON_MODNAME="usb"

src_compile() {
	S=$(ls -d $WORKDIR/*/)
	cd "$S"
}

src_test() {
	cd tests

	testing() {
		PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" testall.py
	}
	python_execute_function testing
}
