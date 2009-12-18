# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Combined DVB reciever, Digital Video Recorder and Showtime
streaming server for Linux."
HOMEPAGE="http://www.lonelycoder.com/hts/"
SRC_URI="http://www.lonelycoder.com/debian/dists/hts/main/source/hts-tvheadend_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="avahi"

DEPEND="media-tv/linuxtv-dvb-headers
        media-video/ffmpeg"
RDEPEND="avahi? ( net-dns/avahi )"

S="${WORKDIR}"/hts-tvheadend-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/settingspath.patch
	epatch "${FILESDIR}"/ffmpeg.patch
}

src_configure() {
	econf $(use_enable avahi) --release
}

pkg_preinst() {
	enewgroup video
	enewuser tvheadend -1 -1 /dev/null video
}

pkg_postinst() {
	chown -R tvheadend:video "${ROOT}"/etc/tvheadend
	chmod -R 700 "${ROOT}"/etc/tvheadend

	elog "Please run rc-update add tvheadend default."
	elog "Then log in the web interface: (http://localhost:9981)"
	elog "and change the password of the default user"
}

src_install() {
	dodir "${ROOT}"/etc/tvheadend
	newbin build.Linux/tvheadend tvheadend
	newman man/tvheadend.1 tvheadend.1
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	

	dodir "${ROOT}"/etc/tvheadend/accesscontrol
	if [ `ls -A "${ROOT}"/etc/tvheadend/accesscontrol | wc -l` -le 0 ]; then
		insinto "${ROOT}"/etc/tvheadend/accesscontrol
		newins "${FILESDIR}"/anonaccess 1
	fi
}
