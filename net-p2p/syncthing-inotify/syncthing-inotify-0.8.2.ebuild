# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
EGO_PN="github.com/syncthing/${PN}"

inherit golang-vcs-snapshot golang-build systemd

DESCRIPTION="File watcher intended for use with Syncthing"
HOMEPAGE="https://github.com/syncthing/syncthing-inotify"
SRC_URI="https://github.com/syncthing/${PN}/archive/v0.6.7.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

DEPEND="dev-go/backoff"
RDEPEND="${DEPEND}
		net-p2p/syncthing"

src_install() {
	dobin syncthing-inotify

	if use systemd; then
		systemd_dounit src/github.com/syncthing/syncthing-inotify/etc/linux-systemd/system/syncthing-inotify@.service
		systemd_douserunit src/github.com/syncthing/syncthing-inotify/etc/linux-systemd/user/syncthing-inotify.service
	fi
}
