CLEAN := git clean
CP := cp
TEX := pdflatex

proceedings.pdf: main-matter.pdf
	$(CP) $< $@

main-matter.pdf: titlepage.pdf copyright-page.pdf message-from-committee.pdf paper12eval.pdf paper10eval.pdf
titlepage.pdf: TEX := xelatex

.PHONY: clean
clean:
	$(CLEAN) -fX

%.pdf: %.tex
	$(TEX) $<
	$(TEX) $<
	$(TEX) $<
