oscad = /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
carriage_source = x-carriage/jonaskuehling_x-carriage_lm8uu.scad
extruder_source = extruder/jonaskuehling_gregs-wade-v3.scad

all:dual-budda-xcarriage.stl dual-budda-extruders.stl dual-budda-idlers.stl

dual-budda-xcarriage.stl: $(carriage_source)
	$(oscad) -o $@ $(carriage_source)

dual-budda-extruders.stl: $(extruder_source)
	$(oscad) -o $@ -D draw_extruder=1 -D draw_idler=0 $(extruder_source)

dual-budda-idlers.stl: $(extruder_source)
	$(oscad) -o $@ -D draw_extruder=0 -D draw_idler=1 $(extruder_source)

# xcarriage.png: $(source)
# 	$(oscad) -o $@ --imagesize=1024,768 $(source) --render
