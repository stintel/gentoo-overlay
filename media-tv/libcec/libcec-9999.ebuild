# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libdbi/libdbi-0.8.3.ebuild,v 1.19 2009/09/23 16:33:36 patrick Exp $

EAPI="3"

inherit eutils git-2 autotools

DESCRIPTION="libcec"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://libcec.pulse-eight.com/"
LICENSE="GPL-2"
RDEPEND=""
DEPEND="${RDEPEND}"
PDEPEND=""
IUSE=""
KEYWORDS="~amd64 ~x86"
SLOT=0

EGIT_REPO_URI="http://github.com/Pulse-Eight/libcec.git"
EGIT_MASTER="master"
EGIT_BRANCH="${EGIT_MASTER}"



src_unpack() {
	git-2_src_unpack
	cd "${S}"
	rm -f configure
}

src_prepare() {
	eautoreconf || die "eautoreconf failed"
}

src_configure() {
	econf
}

src_compile() {
	emake || die "emake failed"
}

src_install () {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
