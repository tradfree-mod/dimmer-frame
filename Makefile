#!/usr/bin/make

SCADC=/usr/bin/openscad
SCADC_FLAGS=""
MKDIR=mkdir -p
OUTDIR=stl

all: directories case pcb-holder

case: \
	$(OUTDIR)/bottom-case.stl

case-ikea: \
	$(OUTDIR)/bottom-case-ikea.stl

pcb-holder: \
	$(OUTDIR)/pcb-holder.stl

pogopin: \
	$(OUTDIR)/pogo-pin.stl

$(OUTDIR)/stubs/%.stl: stubs/%.scad 
	$(SCADC) $(SCADC_FLAGS) -o $@ $<

$(OUTDIR)/%.stl: %.scad 
	$(SCADC) $(SCADC_FLAGS) -o $@ $<

directories:
	$(MKDIR) $(OUTDIR)

clean:
	rm -Rf $(OUTDIR)/*

.PHONY : clean directories
.DEFAULT : case
