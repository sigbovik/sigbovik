CLEAN := git clean
CP := cp
TEX := pdflatex

proceedings.pdf: main-matter.pdf
	$(CP) $< $@

main-matter.pdf: titlepage.pdf copyright-page.pdf message-from-committee.pdf papers.tex
titlepage.pdf: TEX := xelatex

.PHONY: clean
clean:
	$(CLEAN) -fX

%.pdf: %.tex
	cd $(shell dirname $<) && \
		$(TEX) $(shell basename $<)
	cd $(shell dirname $<) && \
		$(TEX) $(shell basename $<)
	cd $(shell dirname $<) && \
		$(TEX) $(shell basename $<)
