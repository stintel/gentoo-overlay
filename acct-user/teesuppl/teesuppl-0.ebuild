# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="User for sys-apps/optee_client"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( "$PN" "tee" "teepriv" )
ACCT_USER_HOME="/var/lib/tee"
ACCT_USER_HOME_PERMS=0700

acct-user_add_deps
