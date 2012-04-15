# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

RESTRICT="mirror strip"

inherit vdr-plugin


if [[ ${PV} == "9999" ]] ; then
	inherit  git
	# Define the environment variable XBMC_EGIT_REPO_URI to track a different repository
	EGIT_REPO_URI=${XBMC_EGIT_REPO_URI:-git://github.com/opdenkamp/xbmc.git}
	# Define the environment variable XBMC_EGIT_BRANCH to track a different branch
	if [[ -n ${XBMC_EGIT_BRANCH} ]] ; then
		EGIT_BRANCH=${XBMC_EGIT_BRANCH}
	fi
	# Define the environment variable XBMC_EGIT_PROJECT if you're tracking a different repository
	# than the official one and would like to store locally in a different folder for easily being
	# able to switch back
	EGIT_PROJECT=${XBMC_EGIT_PROJECT:-xbmc}
	# Define the environment variable XBMC_EGIT_COMMIT to override to a specific GIT commit
	if [[ -n ${XBMC_EGIT_COMMIT} ]] ; then
		EGIT_COMMIT=${XBMC_EGIT_COMMIT}
	fi

else
	SRC_URI="http://mirrors.xbmc.org/releases/source/${P}.tar.gz"
fi


DESCRIPTION="VDR plugin: VNSI Streamserver Plugin"
HOMEPAGE="http://xbmc.org"

KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-video/vdr-1.7.14"
RDEPEND="${DEPEND}"

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		# if we did not request an explicit commit in the environment variable, but a specific branch, get the commit of the requested branch:
		if [[ -z "${XBMC_EGIT_COMMIT}" && -n "${XBMC_EGIT_BRANCH}" ]]; then
			cd "${EGIT_STORE_DIR}/${PN}"
			EGIT_COMMIT="$(git ls-remote --heads origin | grep ${EGIT_BRANCH} | cut -b 1-40)"
		fi
		git_src_unpack
		S="${S}/xbmc/pvrclients/vdr-vnsi/vdr-plugin-vnsiserver"
		cd "${S}"
		rm -f configure
	else
		unpack ${A}
		cd "${S}"
	fi
}


src_prepare() {
	vdr-plugin_src_prepare

	fix_vdr_libsi_include recplayer.c
	fix_vdr_libsi_include receiver.c
}


src_install() {
	vdr-plugin_src_install
	insinto /etc/vdr/plugins/vnsiserver
	doins vnsiserver/allowed_hosts.conf
	if [-f "vnsiserver/noSignal.mpg"]; then
		doins vnsiserver/noSignal.mpg
	fi
	diropts -gvdr -ovdr
}
