#!/usr/bin/make

SCADC=/usr/bin/openscad
SCADC_FLAGS=""
MKDIR=mkdir -p
OUTDIR=stl

all: directories case pogopin

case: \
	$(OUTDIR)/bottom-case.stl

case-ikea: \
	$(OUTDIR)/bottom-case-ikea.stl

pogopin: \
	$(OUTDIR)/pogo-pin.stl

stl/stubs/%.stl: stubs/%.scad 
	$(SCADC) $(SCADC_FLAGS) -o $@ $<

stl/%.stl: %.scad 
	$(SCADC) $(SCADC_FLAGS) -o $@ $<

directories:
	$(MKDIR) $(OUTDIR)

clean:
	rm -Rf $(OUTDIR)/*

.PHONY : clean directories
.DEFAULT : case
