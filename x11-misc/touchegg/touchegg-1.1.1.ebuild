# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="Multitouch gesture recognizer"
HOMEPAGE="https://github.com/JoseExposito/touchegg"
SRC_URI="https://github.com/JoseExposito/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qt4 qt5"

REQUIRED_USE="|| ( qt4 qt5 )"

DEPEND="x11-libs/geis
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXtst"
if use qt4; then
	DEPEND="${DEPEND}
			dev-qt/qtcore:4
			dev-qt/qtgui:4"
else
	DEPEND="${DEPEND}
			dev-qt/qtcore:5
			dev-qt/qtgui:5
			dev-qt/qtwidgets:5
			dev-qt/qtx11extras:5
			dev-qt/qtxml:5"
fi
RDEPEND="${DEPEND}"

S="${S}/${PN}"

src_prepare() {
	use qt5 && epatch "${FILESDIR}/${P}-qt5.patch"
}

src_configure() {
	use qt4 && eqmake4
	use qt5 && eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
