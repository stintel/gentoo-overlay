# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="A tool for integrating Git with Patchwork, the web-based patch tracking system"
HOMEPAGE="https://github.com/getpatchwork/git-pw"

case ${PV} in
	9999)
		inherit git-r3
		KEYWORDS=""
		EGIT_REPO_URI="https://github.com/getpatchwork/${PN}.git"
		;;
	*)
		KEYWORDS="~amd64"
		SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
		;;
esac

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="dev-python/arrow
		dev-python/click
		dev-python/requests
		dev-python/tabulate"
RDEPEND="${DEPEND}"
