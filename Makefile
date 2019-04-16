# Makefile for LaTeX document files
# Created by Baochun Li, bli@eecg.toronto.edu, March 30 2001
# Modified by Zimu Liu, zimu@eecg.toronto.edu, December 8, 2009
# Last modified: December 8, 2009

# Produce PS/PDF/DVI files: make
# Clean all output files: make clean

# Use pdflatex or latex
# ENGINE=pdflatex
ENGINE=xelatex

# Name of the master LaTeX file
DOCUMENT=main

#--------------------------------------------------
# Do NOT change anything below
#--------------------------------------------------

default: $(DOCUMENT).pdf
pdf: $(DOCUMENT).pdf

$(DOCUMENT).toc: $(DOCUMENT).tex
	$(ENGINE) $(DOCUMENT).tex

# ifeq ($(ENGINE), pdflatex)
ifeq ($(ENGINE), xelatex)
#--------------------------------------------------
# pdflatex
#--------------------------------------------------
$(DOCUMENT).pdf: $(DOCUMENT).toc
	bibtex $(DOCUMENT)
	$(ENGINE) $(DOCUMENT).tex
	$(ENGINE) $(DOCUMENT).tex
else
#--------------------------------------------------
# latex
#--------------------------------------------------
$(DOCUMENT).dvi: $(DOCUMENT).toc
	bibtex $(DOCUMENT)
	$(ENGINE) $(DOCUMENT).tex
	$(ENGINE) $(DOCUMENT).tex

$(DOCUMENT).ps: $(DOCUMENT).dvi
	dvips -t letter -Ppdf -G0 -o $@ $<

$(DOCUMENT).pdf: $(DOCUMENT).ps
	cat $(DOCUMENT).ps | ps2pdf - > $(DOCUMENT).pdf 
endif

all: $(DOCUMENT).pdf

clean:
	rm -rf $(DOCUMENT).aux $(DOCUMENT).log $(DOCUMENT).toc \
	$(DOCUMENT).bbl $(DOCUMENT).blg \
	$(DOCUMENT).ps $(DOCUMENT).dvi $(DOCUMENT).synctex.gz \
	$(DOCUMENT).ind $(DOCUMENT).inx $(DOCUMENT).gls \
	$(DOCUMENT).glo $(DOCUMENT).bak $(DOCUMENT).brf \
	$(DOCUMENT).idx $(DOCUMENT).ilg $(DOCUMENT).out \
	
