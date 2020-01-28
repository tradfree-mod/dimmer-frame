#!/usr/bin/make

SCADC=/usr/bin/openscad
MKDIR=mkdir -p
OUTDIR=stl

all: directories case pogopin

case: \
	$(OUTDIR)/main.stl

pogopin: \
	$(OUTDIR)/pogo-pin.stl

stl/stubs/%.stl: stubs/%.scad 
	$(SCADC) -o $@ $<

stl/%.stl: %.scad 
	$(SCADC) -o $@ $<

directories:
	$(MKDIR) $(OUTDIR)

clean:
	rm -Rf $(OUTDIR)/*

.PHONY : clean directories
.DEFAULT : all
