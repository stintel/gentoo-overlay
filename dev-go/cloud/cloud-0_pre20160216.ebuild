# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="google.golang.org/cloud"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64"
	EGIT_COMMIT="bd07e35fb26a22eb33298ff0cba169221803eb81"
	SRC_URI="https://github.com/GoogleCloudPlatform/google-cloud-go/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Go on Google Cloud Platform"
HOMEPAGE="https://cloud.google.com/go/home"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND=""
RDEPEND=""
