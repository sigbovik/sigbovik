CLEAN := git clean
CP := cp
TEX := pdflatex

proceedings.pdf: main-matter.pdf
	$(CP) $< $@

main-matter.pdf: titlepage.pdf copyright-page.pdf message-from-committee.pdf reviews/SIGBOVIK_2017_review-11.pdf reviews/SIGBOVIK_2017_review-14.pdf reviews/SIGBOVIK_2017_review-23.pdf reviews/SIGBOVIK_2017_review-75.pdf reviews/SIGBOVIK_2017_review-79.pdf reviews/SIGBOVIK_2017_review-90.pdf reviews/SIGBOVIK_2017_review-91.pdf reviews/SIGBOVIK_2017_review-92.pdf papers.tex
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
