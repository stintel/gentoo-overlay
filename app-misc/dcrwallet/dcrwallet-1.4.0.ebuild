# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
EGO_PN="github.com/decred/dcrwallet"
EGO_VENDOR=(
"github.com/agl/ed25519 5312a61534124124185d41f09206b9fef1d88403"
"github.com/boltdb/bolt 2f1ce7a837dcb8da3ec595b1dac9d0632f0f99e8"
"github.com/btcsuite/go-socks 4720035b7bfd2a9bb130b1c184f8bbe41b6f0d0f"
#"github.com/btcsuite/goleveldb 3fd0373267b6461dbefe91cef614278064d05465"
#"github.com/btcsuite/snappy-go b3db38edf0a9a11a115eb6b022d8c946024a9ac0"
#"github.com/davecgh/go-spew d8f796af33cc11cb798c1aaeb27a4ebc5099927d"
"github.com/dchest/blake256 dee3fe6eb0e98dc774a94fc231f85baf7c29d360"
"github.com/dchest/siphash 34f201214d993633bb24f418ba11736ab8b55aa7"
"github.com/decred/base58 dbeddd8aab76c31eb2ea98351a63fa2c6bf46888"
"github.com/decred/dcrd e3e8c47c68b010dbddeb783ebad32a3a4993dd71"
"github.com/decred/slog 0af93b84a83200ce75049b5b50cd7cbef4daa162"
"github.com/golang/protobuf aa810b61a9c79d51363740d207bb46cf8e620ed5"
"github.com/gorilla/websocket 0ec3d1bd7fe50c503d6df98ee649d81f4857c564"
"github.com/jessevdk/go-flags c0795c8afcf41dd1d786bebce68636c199b3bb45"
"github.com/jrick/bitset 06eae37cdf93c699c0503c23f998167ce841974c"
"github.com/jrick/logrotate a93b200c26cbae3bb09dd0dc2c7c7fe1468a034a"
"golang.org/x/crypto b8fe1690c61389d7d2a8074a507d1d40c5d30448 github.com/golang/crypto"
"golang.org/x/net d26f9f9a57f3fab6a695bec0d84433c2c50f8bbf github.com/golang/net"
"golang.org/x/sync 37e7f081c4d4c64e13b10787722085407fe5d15f github.com/golang/sync"
"golang.org/x/sys d0b11bdaac8adb652bff00e49bcacf992835621a github.com/golang/sys"
"golang.org/x/text f21a4dfb5e38f5895301dc265a8def02365cc3d0 github.com/golang/text"
"google.golang.org/genproto c66870c02cf823ceb633bcd05be3c7cda29976f4 github.com/google/go-genproto"
"google.golang.org/grpc ce08908258b7dc7d5c25259760589acdf3bf3789 github.com/grpc/grpc-go"
)

ARCHIVE_URI="https://${EGO_PN}/archive/release-v${PV}.tar.gz -> ${P}.tar.gz"

inherit golang-build golang-vcs-snapshot systemd user

DESCRIPTION="dcrctl"
HOMEPAGE="https://github.com/decred/dcrwallet"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

DEPEND=""
RDEPEND="~app-misc/dcrctl-${PV}"

PUSER="decred"
PUG="${PUSER}:${PUSER}"
PHOME="/var/lib/${PUSER}"
PCONFDIR="/etc/decred"
PCONFFILE="${PCONFDIR}/dcrwallet.conf"

pkg_setup() {
	enewgroup "${PUSER}"
	enewuser "${PUSER}" -1 -1 "${PHOME}" "${PUSER}"
}

src_install() {
	dobin dcrwallet

	dodoc -r "${S}/src/${EGO_PN}/docs/"

	insinto "${PCONFDIR}"
	newins "${S}/src/${EGO_PN}/sample-dcrwallet.conf" dcrwallet.conf
	fowners "${PUG}" "${PCONFFILE}"
	fperms 600 "${PCONFFILE}"

	keepdir "${PHOME}"/.dcrwallet
	fperms 700 "${PHOME}"
	fowners "${PUG}" "${PHOME}"
	fowners "${PUG}" "${PHOME}"/.dcrwallet
	dosym "${PCONFFILE}" "${PHOME}"/.dcrwallet/dcrwallet.conf

	if use systemd; then
		systemd_dounit "${FILESDIR}/${PN}.service"
		systemd_newuserunit "${FILESDIR}/${PN}.service.user" "${PN}.service"
	fi
}
