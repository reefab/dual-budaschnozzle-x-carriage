oscad = /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
carriage_source = x-carriage/main.scad
extruder_source = extruder/jonaskuehling_gregs-wade-v3.scad

all:dual-budda-xcarriage.stl dual-budda-extruders.stl dual-budda-idlers.stl dual-budda-beltclamps.stl dual-budda-side_fanduct.stl dual-budda-rear_fanduct.stl

dual-budda-xcarriage.stl: $(carriage_source)
	$(oscad) -o $@ -D draw_carriage=1 -D draw_belt_clamps=0 -D draw_side_fan_duct=0 -D draw_rear_fan_duct=0 $(carriage_source)

dual-budda-beltclamps.stl: $(carriage_source)
	$(oscad) -o $@ -D draw_carriage=0 -D draw_belt_clamps=1 -D draw_side_fan_duct=0 -D draw_rear_fan_duct=0 $(carriage_source)

dual-budda-side_fanduct.stl: $(carriage_source)
	$(oscad) -o $@ -D draw_carriage=0 -D draw_belt_clamps=0 -D draw_side_fan_duct=1 -D draw_rear_fan_duct=0 $(carriage_source)

dual-budda-rear_fanduct.stl: $(carriage_source)
	$(oscad) -o $@ -D draw_carriage=0 -D draw_belt_clamps=0 -D draw_side_fan_duct=0 -D draw_rear_fan_duct=1 $(carriage_source)

dual-budda-extruders.stl: $(extruder_source)
	$(oscad) -o $@ -D draw_extruder=1 -D draw_idler=0 $(extruder_source)

dual-budda-idlers.stl: $(extruder_source)
	$(oscad) -o $@ -D draw_extruder=0 -D draw_idler=1 $(extruder_source)

clean:
	rm *.stl
