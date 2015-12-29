# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
EGO_PN="github.com/zillode/${PN}"

inherit golang-vcs golang-build

DESCRIPTION="Filesystem event notification library on steroids"
HOMEPAGE="https://github.com/zillode/notify"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
