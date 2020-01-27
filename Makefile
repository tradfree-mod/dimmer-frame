#!/usr/bin/make

SCADC=/usr/bin/openscad
MKDIR=mkdir -p
OUTDIR=stl

all: stubs case directories

stubs:
	echo "-"

case: \
	$(OUTDIR)/main.stl


stl/stubs/%.stl: stubs/%.scad 
	$(SCADC) -o $@ $<

stl/%.stl: %.scad 
	$(SCADC) -o $@ $<

directories:
	$(MKDIR) $(OUTDIR)/stubs

clean:
	rm -Rf $(OUTDIR)/*

.PHONY : clean directories
.DEFAULT : all
