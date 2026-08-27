# Re-export the STLs and the doc images from the parametric source.
#   make          both parts
#   make preview  re-render the images, light and dark
#   make clean    drop the exported STLs

OPENSCAD ?= openscad
SRC      := src/skadis_101_mount.scad
PARTS    := bracket hooks

# Renders are deliberately uniform: same size, same orthographic projection,
# same elevation, one colour scheme per theme. Only the azimuth differs, so
# each part is seen from the side that shows its pegs.
VIEW           := --viewall --autocenter --projection=o --imgsize=1000,1000 --render
CAM_bracket    := 0,0,0,60,0,30,0
CAM_hooks      := 0,0,0,60,0,300,0
SCHEME_light   := Nature
SCHEME_dark    := Tomorrow Night

STLS := $(PARTS:%=stl/101_skadis_%.stl)
PNGS := $(PARTS:%=docs/images/%-light.png) $(PARTS:%=docs/images/%-dark.png)

.PHONY: all preview clean
all: $(STLS)

stl/101_skadis_%.stl: $(SRC)
	$(OPENSCAD) -o $@ -D 'part="$*"' $<

preview: $(PNGS)

docs/images/%-light.png: $(SRC)
	$(OPENSCAD) -q -o $@ --camera=$(CAM_$*) $(VIEW) --colorscheme="$(SCHEME_light)" -D 'part="$*"' $<

docs/images/%-dark.png: $(SRC)
	$(OPENSCAD) -q -o $@ --camera=$(CAM_$*) $(VIEW) --colorscheme="$(SCHEME_dark)" -D 'part="$*"' $<

clean:
	rm -f $(STLS)
