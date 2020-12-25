# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="User for net-irc/matrix-ircd"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( "$PN" )
ACCT_USER_HOME="/dev/null"

acct-user_add_deps
