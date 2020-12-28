# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="MQTT Client for Qt"
HOMEPAGE="http://emqtt.io/"
SRC_URI="https://github.com/emqtt/${PN}/archive/v0.1/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcore:5
		dev-qt/qtnetwork:5"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
