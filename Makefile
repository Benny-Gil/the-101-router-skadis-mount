# Re-export the STLs from the parametric source.
#   make          both parts
#   make preview  re-render the README images
#   make clean    drop the exported STLs

OPENSCAD ?= openscad
SRC      := src/skadis_101_mount.scad
PARTS    := bracket hooks

STLS := $(PARTS:%=stl/101_skadis_%.stl)
PNGS := $(PARTS:%=docs/images/%.png)

.PHONY: all preview clean
all: $(STLS)

stl/101_skadis_%.stl: $(SRC)
	$(OPENSCAD) -o $@ -D 'part="$*"' $<

preview: $(PNGS)

docs/images/%.png: $(SRC)
	$(OPENSCAD) -o $@ --imgsize=1000,800 --autocenter --viewall -D 'part="$*"' $<

clean:
	rm -f $(STLS)
