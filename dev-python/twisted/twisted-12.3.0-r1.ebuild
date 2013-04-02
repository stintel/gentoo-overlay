# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted/twisted-12.3.0.ebuild,v 1.1 2013/01/14 03:54:33 patrick Exp $

EAPI="5"
PYTHON_COMPAT=(python2_{6,7} pypy{1_9,2_0})
# A couple of failures (refcounting, version-checking), but sufficiently
# functional to be useful, so restrict just the tests.
PYTHON_TESTS_RESTRICTED_ABIS="*-pypy-*"
MY_PACKAGE="Core"

inherit eutils twisted-r1 versionator

DESCRIPTION="An asynchronous networking framework written in Python"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="crypt gtk serial"

DEPEND="net-zope/zope-interface
	crypt? ( >=dev-python/pyopenssl-0.10 )
	gtk? ( dev-python/pygtk:2 )
	serial? ( dev-python/pyserial )"
RDEPEND="${DEPEND}"

# Needed to make the sendmsg extension work
# (see http://twistedmatrix.com/trac/ticket/5701 )
PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS=( CREDITS NEWS README )

src_prepare(){
	distutils-r1_src_prepare

	# Give a load-sensitive test a better chance of succeeding.
	epatch "${FILESDIR}/${PN}-2.1.0-echo-less.patch"

	# Skip a test if twisted conch is not available
	# (see Twisted ticket #5703)
	epatch "${FILESDIR}/twisted-12.1.0-remove-tests-conch-dependency.patch"

	# Respect TWISTED_DISABLE_WRITING_OF_PLUGIN_CACHE variable.
	epatch "${FILESDIR}/${PN}-9.0.0-respect_TWISTED_DISABLE_WRITING_OF_PLUGIN_CACHE.patch"

	if [[ "${EUID}" -eq 0 ]]; then
		# Disable tests failing with root permissions.
		sed \
			-e "s/test_newPluginsOnReadOnlyPath/_&/" \
			-e "s/test_deployedMode/_&/" \
			-i twisted/test/test_plugin.py
	fi
}

src_install() {
	distutils-r1_src_install

	# Don't install index.xhtml page.
	doman doc/man/*.?
	insinto /usr/share/doc/${PF}
	doins -r $(find doc -mindepth 1 -maxdepth 1 -not -name man)

	newconfd "${FILESDIR}/twistd.conf" twistd
	newinitd "${FILESDIR}/twistd.init" twistd
}
