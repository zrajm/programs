# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $


# Ebuild by Zrajm C Akfohg <zrajm@klingonska.org> [2004-10-20]
DESCRIPTION="Daemon for logging caller ID of incoming calls (via syslog)."
HOMEPAGE="http://www.update.uu.se/~zrajm/programs/"
SRC_URI="http://www.update.uu.se/~zrajm/programs/${PN}/${P}.tar.gz"
LICENSE=""

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
RDEPEND="dev-lang/perl
	virtual/logger
	sys-apps/util-linux"
S=${WORKDIR}/${PN}

src_install() {
	dosbin phoned
	exeinto /etc/init.d
	doexe init.d/phoned
	dodoc README
	docinto metalog
	dodoc metalog/phone-alert.sh
}
