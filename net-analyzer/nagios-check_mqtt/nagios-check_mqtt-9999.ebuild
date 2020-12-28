# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="A Nagios/Icinga plugin for testing an MQTT broker"
HOMEPAGE="https://github.com/jpmens/check-mqtt"

EGIT_REPO_URI="https://github.com/jpmens/check-mqtt.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/paho-mqtt
		dev-lang/python:*[ssl]"
RDEPEND="${DEPEND}"

src_install() {
	local nagiosplugindir=/usr/$(get_libdir)/nagios/plugins
	exeinto ${nagiosplugindir}
	doexe check-mqtt.py check_mqtt

	dodoc README.md
}
