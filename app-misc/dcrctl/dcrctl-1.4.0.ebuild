# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
EGO_PN="github.com/decred/dcrd"
EGO_VENDOR=(
"github.com/agl/ed25519 5312a61534124124185d41f09206b9fef1d88403"
"github.com/btcsuite/go-socks 4720035b7bfd2a9bb130b1c184f8bbe41b6f0d0f"
"github.com/dchest/blake256 dee3fe6eb0e98dc774a94fc231f85baf7c29d360"
"github.com/decred/base58 dbeddd8aab76c31eb2ea98351a63fa2c6bf46888"
"github.com/jessevdk/go-flags c0795c8afcf41dd1d786bebce68636c199b3bb45"
"golang.org/x/crypto b8fe1690c61389d7d2a8074a507d1d40c5d30448 github.com/golang/crypto"
)

ARCHIVE_URI="https://${EGO_PN}/archive/release-v${PV}.tar.gz -> ${P}.tar.gz"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="dcrctl"
HOMEPAGE="https://github.com/decred/dcrd/tree/master/cmd/dcrctl"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	GOPATH="${WORKDIR}/${P}" go build -v -o dcrctl ${EGO_PN}/cmd/dcrctl || die
}

src_install() {
	dobin dcrctl
}
