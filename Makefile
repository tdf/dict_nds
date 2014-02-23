# nds_de dictionary
#
# (c) 2014 Thorsten Behrens <tbehrens@acm.org>
#
# MIT-style license
#

OUTDIR:=.lib

$(OUTDIR)/Dictionaries.xcu: Dictionaries.xcu
	mkdir -p $(OUTDIR); cp Dictionaries.xcu $(OUTDIR)/

$(OUTDIR)/nds_de.aff: nds_de.aff
	mkdir -p $(OUTDIR); cp nds_de.aff $(OUTDIR)/
$(OUTDIR)/nds_de.dic: nds_de.dic
	mkdir -p $(OUTDIR); cp nds_de.dic $(OUTDIR)/
$(OUTDIR)/README: README
	mkdir -p $(OUTDIR); cp README $(OUTDIR)/

$(OUTDIR)/description.xml: description.xml
	mkdir -p $(OUTDIR); cp description.xml $(OUTDIR)/
$(OUTDIR)/description-en.txt: description-en.txt
	mkdir -p $(OUTDIR); cp description-en.txt $(OUTDIR)/
$(OUTDIR)/description-de.txt: description-de.txt
	mkdir -p $(OUTDIR); cp description-de.txt $(OUTDIR)/
$(OUTDIR)/description-nds.txt: description-nds.txt
	mkdir -p $(OUTDIR); cp description-nds.txt $(OUTDIR)/

$(OUTDIR)/META-INF/manifest.xml: manifest.xml
	mkdir -p -p $(OUTDIR)/META-INF; cp manifest.xml $(OUTDIR)/META-INF/

dict-nds_de.oxt: $(OUTDIR)/Dictionaries.xcu $(OUTDIR)/nds_de.aff $(OUTDIR)/nds_de.dic \
                 $(OUTDIR)/README $(OUTDIR)/description.xml $(OUTDIR)/description-en.txt \
                 $(OUTDIR)/description-de.txt $(OUTDIR)/description-nds.txt \
                 $(OUTDIR)/META-INF/manifest.xml
	cd $(OUTDIR); zip -r dict-nds_de.oxt *

.PHONY all: dict-nds_de.oxt

.PHONY clean:
	rm -fr .lib
