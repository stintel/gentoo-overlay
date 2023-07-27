# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_MAX_SLOT=15
inherit cargo llvm git-r3

DESCRIPTION="Forward auditd events over MQTT"
HOMEPAGE="https://codeberg.org/stintel/auditd-forwarder"
EGIT_REPO_URI="https://codeberg.org/stintel/auditd-forwarder.git"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 EPL-1.0 GPL-3 GPL-3+ ISC MIT Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	sys-devel/clang
	virtual/rust"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	cargo_src_install
	newinitd "${FILESDIR}/${PN}.init" "${PN}"
}
