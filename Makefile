# nds_de dictionary
#
# (c) 2014 Thorsten Behrens <tbehrens@acm.org>
#
# MIT-style license
#

OUTDIR:=dist

dict-nds_de.oxt: $(OUTDIR)/Dictionaries.xcu $(OUTDIR)/nds_de.aff $(OUTDIR)/nds_de.dic \
                 $(OUTDIR)/README $(OUTDIR)/description.xml $(OUTDIR)/description-en.txt \
                 $(OUTDIR)/description-de.txt $(OUTDIR)/description-nds.txt \
                 $(OUTDIR)/META-INF/manifest.xml $(OUTDIR)/COPYING $(OUTDIR)/Copyright
	cd $(OUTDIR); zip -r dict-nds_de.oxt *

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
$(OUTDIR)/COPYING: COPYING
	mkdir -p $(OUTDIR); cp COPYING $(OUTDIR)/
$(OUTDIR)/Copyright: Copyright
	mkdir -p $(OUTDIR); cp Copyright $(OUTDIR)/

# cat: die beiden Wortlisten zusammenfuegen
# sed: wortweise umbrechen
# grep: Leerzeilen entfernen
nds.wl: woortlist.txt egennaams.txt knabbe_woortlist.txt
	cat $+ | perl preprocess.pl \
	sed {"s/-/\n/g;s/[\(][^\)]*[\)]//g;s/\ *\#.*//g;s/ /\n/g"} | grep [a-zA-ZäÄöÖüÜß\/] > $@

# Anzahl Eintraege ermitteln. Direkter Aufruf von wc wuerde "#Anzahl
# nds.wl" ergeben, wir brauchen aber nur die Zahl, daher Umweg ueber
# cat
count.txt: nds.wl
	cat nds.wl | wc -l > $@

# Zusammensetzen: Anzahl Eintraege gefolgt von Wortliste
nds_de.dic: nds.wl count.txt
	cat count.txt nds.wl > $@

$(OUTDIR)/META-INF/manifest.xml: manifest.xml
	mkdir -p -p $(OUTDIR)/META-INF; cp manifest.xml $(OUTDIR)/META-INF/


$(OUTDIR)/alltexts.txt: test/sample*.txt
	cat test/sample*.txt > $@

.PHONY: check
check: $(OUTDIR)/alltexts.txt test/sample*.txt
	hunspell -1 -d nds_de -m test/sample*.txt | diff -wu $(OUTDIR)/alltexts.txt -

.PHONY: all
all: dict-nds_de.oxt

.PHONY: clean
clean:
	rm -fr dist count.txt nds.wl nds_de.dic
