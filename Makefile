
#
#	David Meyer
#	dmm@1-4-5.net
#	Wed Jun 11 12:44:40 2003
#
#	$Header: /home/dmm/generic_draft/RCS/Makefile,v 1.1 2003/06/11 19:56:43 dmm Exp $
#
#
#	Fill in -ifex
#


all: draft-ifex-00.ms draft-ifex-00.txt

GROFF_VERSION!=	groff -v < /dev/null 2>&1 | awk -F. '{print $$2}'
duh:
	echo ${GROFF_VERSION}

# .if ${GROFF_VERSION} != 14
# GROFF_FLAGS=	-U
# .else
# GROFF_FLAGS=
# .endif

GROFF_FLAGS=	-U

.SUFFIXES:	.ms .ps .txt .html

# 2 passes are now always needed, due to TOC issues.
# If the TOC in the existing refs.txt is too much shorter,
# 3 passes are needed, but let's ignore that for now.
#
.ms.ps:	tmac.ref
	# 1st pass: create references
	tbl $< | groff -ms ${GROFF_FLAGS} > /dev/null 2>&1
	# 2nd pass: create document
	tbl $< | groff -ms ${GROFF_FLAGS} > $@

.ms.txt:	tmac.ref
	# 1st pass: create references
	tbl $< | groff -ms ${GROFF_FLAGS} -Tascii > /dev/null 2>&1
	# 2nd pass: create document
	tbl $< | groff -ms ${GROFF_FLAGS} -Tascii | ./build-utilities/todraft > $@
