oscad = /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
source = jonaskuehling_x-carriage_lm8uu.scad

all:dual-budda-xcarriage.stl preview.png

dual-budda-xcarriage.stl: $(source) 
	$(oscad) -o $@ $(source)

preview.png: $(source)
	$(oscad) -o $@ --imagesize=1024,768 $(source) --render
