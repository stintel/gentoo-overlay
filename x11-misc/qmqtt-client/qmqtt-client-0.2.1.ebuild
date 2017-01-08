# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="MQTT Client GUI Written with Qt"
HOMEPAGE="http://emqtt.io/"
SRC_URI="https://github.com/emqtt/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-misc/qmqtt"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr" INCLUDEPATH="/usr/include/qmqtt"
}

src_install() {
	dobin "${S}/${PN}"
}
