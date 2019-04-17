# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="Multitouch gesture recognizer"
HOMEPAGE="https://github.com/JoseExposito/touchegg"
SRC_URI="https://github.com/JoseExposito/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtx11extras:5
		dev-qt/qtxml:5
		x11-libs/geis
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXtst"
RDEPEND="${DEPEND}"

S="${S}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${P}-qt5.patch"
}

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
