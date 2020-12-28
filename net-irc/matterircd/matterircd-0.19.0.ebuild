# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit golang-build golang-vcs-snapshot

EGO_PN=github.com/42wim/matterircd

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
	KEYWORDS=""
else
	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~arm ~amd64"
fi

DESCRIPTION="Connect to your mattermost or slack using your IRC-client of choice."
HOMEPAGE="https://github.com/42wim/matterircd"
LICENSE="MIT"
SLOT="0"
IUSE=""

src_install() {
	dobin ${PN}
	newinitd "${FILESDIR}"/${PN}.init ${PN}

	insinto /etc/
	newins "${S}/src/${EGO_PN}/matterircd.toml.example" matterircd.toml
}
