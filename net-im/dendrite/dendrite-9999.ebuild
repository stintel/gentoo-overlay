# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module unpacker

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/element-hq/dendrite.git"
	KEYWORDS=""
else

KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/element-hq/dendrite/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://gentoo.adlevio.net/${P}-deps.tar.zst"

fi

DESCRIPTION="Dendrite is a second-generation Matrix homeserver written in Go!"
HOMEPAGE="https://github.com/element-hq/dendrite"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="acct-user/dendrite ${DEPEND}"
BDEPEND=">=dev-lang/go-1.22.0"

src_unpack() {
	if [[ ${PV} == *9999 ]]; then
		git-r3_src_unpack
		go-module_live_vendor
	else
		unpacker_src_unpack
		go-module_src_unpack
	fi
}

src_compile() {
	# bug 906073
	use elibc_musl && export CGO_CFLAGS="-D_LARGEFILE64_SOURCE"

	GOBIN="${S}/bin" go install -trimpath -v "${S}/./cmd/..." || die
}

src_install() {
	# Put SQLite databases in /var/lib/dendrite
	sed -i 's"connection_string: file:"connection_string: file:/var/lib/dendrite/"' dendrite-sample.yaml || die

	dobin "${S}/bin/"*

	insinto /etc/dendrite
	newins dendrite-sample.yaml dendrite.yaml

	newconfd "${FILESDIR}/dendrite.conf" dendrite
	newinitd "${FILESDIR}/dendrite.init" dendrite

	keepdir /var/log/dendrite
	fowners dendrite:dendrite /var/log/dendrite
}
