# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic git-r3

DESCRIPTION="Userspace tools for bcachefs"
HOMEPAGE="http://bcachefs.org/"

EGIT_REPO_URI="https://github.com/koverstreet/bcachefs-tools.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"
IUSE=""

DEPEND="app-arch/lz4
		app-arch/zstd
		app-crypt/libscrypt
		dev-libs/libaio
		dev-libs/libsodium
		dev-libs/userspace-rcu
		dev-util/valgrind
		sys-apps/keyutils"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	sed -i 's/ -O2//' Makefile

	if use elibc_musl; then
		append-cflags -DPAGE_SHIFT=12
		append-cflags -D__always_inline=inline
		append-cflags -D\''__attribute_const__=__attribute__((__const__))'\'
	fi

	default
}

src_compile() {
	emake D="" "$@" || die "died running emake, $FUNCNAME"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" "$@" install || die "died running make install, $FUNCNAME"
}
