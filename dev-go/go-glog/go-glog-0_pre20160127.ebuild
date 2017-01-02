# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/golang/glog"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64"
	EGIT_COMMIT="23def4e6c14b4da8ac2ed8007337bc5eb5007998"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Leveled execution logs for Go"
HOMEPAGE="https://github.com/golang/glog"
LICENSE="Apache-2.0"
SLOT="0/${PVR}"
IUSE=""
RESTRICT="test"
DEPEND=""
RDEPEND=""
