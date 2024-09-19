# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Slack module for libpurple"
HOMEPAGE="https://github.com/dylex/slack-libpurple"

EGIT_REPO_URI="https://github.com/dylex/slack-libpurple.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="net-im/pidgin"
RDEPEND="${DEPEND}"
