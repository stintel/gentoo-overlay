# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

MyPN="touchegg"
MyP="${MyPN}-${PV}"

DESCRIPTION="Multitouch gesture recognizer"
HOMEPAGE="https://github.com/JoseExposito/touchegg"
SRC_URI="https://github.com/JoseExposito/${MyPN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtx11extras:5
		dev-qt/qtxml:5
		media-libs/mesa
		x11-misc/touchegg"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MyP}/${PN}"

src_prepare() {
	eapply "${FILESDIR}/${P}-config_path.patch"
	eapply "${FILESDIR}/${P}-qt5.patch"

	default
}

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
