# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $


# Ebuild by Zrajm C Akfohg <zrajm@klingonska.org> [2003-03-29]
DESCRIPTION="Shell command for displaying menus in X"
HOMEPAGE="http://www.update.uu.se/~zrajm/programs/"
SRC_URI="http://www.update.uu.se/~zrajm/programs/${PN}/${P}.tar.gz"
LICENSE=""

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lang/perl" # pod2man in src_compile is part of perl
RDEPEND="virtual/x11"

src_compile() {
	pod2man ratmen.c > ratmen.1
	emake || die
}

src_install() {
	dobin ratmen
	doman ratmen.1
	dodoc ChangeLog README*
}

