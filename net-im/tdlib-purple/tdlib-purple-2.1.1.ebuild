# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
inherit cmake python-any-r1

MY_COMMIT="30e2d6d204a3f51286d3a2b6c4bf470145b71d53"

DESCRIPTION="Telegram protocol plugin for libpurple"
HOMEPAGE="https://github.com/adrighem/tdlib-purple"
SRC_URI="https://github.com/adrighem/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="webp"

# Upstream integration tests include live Telegram account tests.
RESTRICT="test"

DEPEND="
	dev-libs/glib:2
	dev-libs/libfmt:=
	media-gfx/qrencode:=
	media-libs/libpng:=
	media-libs/rlottie:=
	net-im/pidgin
	~net-libs/tdlib-1.8.69:0=
	virtual/libintl
	virtual/zlib:=
	webp? ( media-libs/libwebp:= )
"
RDEPEND="${DEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	sys-devel/gettext
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}/${P}-link-zlib.patch" )

src_configure() {
	local mycmakeargs=(
		-DNoBundledFmt=ON
		-DNoBundledLottie=ON
		-DNoVoip=ON
		-DNoWebp=$(usex webp OFF ON)
		-DPython3_EXECUTABLE="${PYTHON}"
	)
	cmake_src_configure
}

src_install() {
	# Ninja's install target reruns the build user's credential generator.
	DESTDIR="${D}" "${CMAKE_BINARY}" --install "${BUILD_DIR}" || die
	einstalldocs
}
