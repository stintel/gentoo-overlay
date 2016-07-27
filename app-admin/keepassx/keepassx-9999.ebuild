# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="Qt password manager compatible with its Win32 and Pocket PC versions"
HOMEPAGE="http://www.keepassx.org/"

EGIT_REPO_URI="https://github.com/keepassx/keepassx.git"

LICENSE="|| ( GPL-2 GPL-3 ) BSD GPL-2 LGPL-2.1 LGPL-3+ CC0-1.0 public-domain || ( LGPL-2.1 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="qt4 qt5 test"

REQUIRED_USE="^^ ( qt4 qt5 )"

DEPEND="
	>=dev-libs/libgcrypt-1.6.0:0=
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXtst
"
if use qt4; then
	DEPEND="${DEPEND}
		dev-qt/qtcore:4
		dev-qt/qtdbus:4
		dev-qt/qtgui:4
		dev-qt/qttest:4
	"
elif use qt5; then
	DEPEND="${DEPEND}
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qttest:5
	"
fi
RDEPEND="${DEPEND}"

DOCS=(CHANGELOG)

src_unpack() {
	git-r3_src_unpack
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with test TESTS)
	)
	cmake-utils_src_configure
}
