# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
EGO_PN="github.com/cenkalti/${PN}"

inherit golang-vcs golang-build

DESCRIPTION="The exponential backoff algorithm in Go"
HOMEPAGE="https://github.com/cenkalti/backoff"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-go/notify"
RDEPEND="${DEPEND}"
