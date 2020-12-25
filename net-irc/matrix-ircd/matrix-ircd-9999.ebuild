# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo git-r3

DESCRIPTION="An IRCd implementation backed by Matrix"
HOMEPAGE="https://matrix.org/docs/projects/client/matrix-ircd/"

EGIT_REPO_URI="https://github.com/matrix-org/matrix-ircd.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="acct-user/matrix-ircd ${DEPEND}"
BDEPEND=""

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_configure() {
	cargo_src_configure
}

src_compile() {
	cargo_src_compile
}

src_install() {
	dobin target/release/matrix-ircd

	newconfd "${FILESDIR}/matrix-ircd.conf" matrix-ircd
	newinitd "${FILESDIR}/matrix-ircd.init" matrix-ircd

	keepdir /var/log/matrix-ircd
	fowners matrix-ircd:matrix-ircd /var/log/matrix-ircd
}
