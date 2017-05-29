# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit eutils systemd user python-any-r1

DESCRIPTION="An Open Source MQTT v3 Broker"
HOMEPAGE="http://mosquitto.org/"
SRC_URI="http://mosquitto.org/files/source/${P}.tar.gz"
LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bridge examples libressl +persistence psk +srv ssl tcpd websockets"

RDEPEND="tcpd? ( sys-apps/tcp-wrappers )
	ssl? (
		libressl? ( dev-libs/libressl )
		!libressl? ( dev-libs/openssl:0= )
	)
	srv? ( net-dns/c-ares )
	websockets? ( net-libs/libwebsockets )"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}"
USE_DEPEND="libressl? ( !psk )"

pkg_setup() {
	enewgroup mosquitto
	enewuser mosquitto -1 -1 -1 mosquitto
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.4.11-conditional-tests.patch"
	epatch "${FILESDIR}/${PN}-1.4.11-libressl.patch"
	if use persistence; then
		sed -i -e "s:^#autosave_interval:autosave_interval:" \
			-e "s:^#persistence false$:persistence true:" \
			-e "s:^#persistence_file:persistence_file:" \
			-e "s:^#persistence_location$:persistence_location /var/lib/mosquitto/:" \
			mosquitto.conf || die
	fi
	python_setup
	python_fix_shebang test
}

src_configure() {
	LIBDIR=$(get_libdir)
	QA_PRESTRIPPED="/usr/sbin/mosquitto
		/usr/bin/mosquitto_passwd
		/usr/bin/mosquitto_sub
		/usr/bin/mosquitto_pub
		/usr/${LIBDIR}/libmosquittopp.so.1
		/usr/${LIBDIR}/libmosquitto.so.1"

	makeopts=(
		"LIB_SUFFIX=${LIBDIR:3}"
		"WITH_BRIDGE=$(usex bridge)"
		"WITH_PERSISTENCE=$(usex persistence)"
		"WITH_SRV=$(usex srv)"
		"WITH_TLS=$(usex ssl)"
		"WITH_TLS_PSK=$(usex psk)"
		"WITH_WEBSOCKETS=$(usex websockets)"
		"WITH_WRAP=$(usex tcpd)"
	)
}

src_compile() {
	emake "${makeopts[@]}"
}

src_test() {
	emake "${makeopts[@]}" test
}

src_install() {
	emake "${makeopts[@]}" DESTDIR="${D}" prefix=/usr install
	keepdir /var/lib/mosquitto
	fowners mosquitto:mosquitto /var/lib/mosquitto
	dodoc readme.md CONTRIBUTING.md ChangeLog.txt
	doinitd "${FILESDIR}"/mosquitto
	insinto /etc/mosquitto
	doins mosquitto.conf
	systemd_dounit "${FILESDIR}/mosquitto.service"

	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		insinto "/usr/share/doc/${PF}/examples"
		doins -r examples/*
	fi
}

pkg_postinst() {
	elog ""
	elog "The Python module has been moved out of mosquitto."
	elog "See http://mosquitto.org/documentation/python/"
	elog ""
	elog "To start the mosquitto daemon at boot, add it to the default runlevel with:"
	elog ""
	elog "    rc-update add mosquitto default"
	elog "    or"
	elog "    systemctl enable mosquitto"
}
