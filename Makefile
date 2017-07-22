oscad = /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
main = complete.scad
configuration_file = configuration.scad
output_dir = stl/
carriage_source = src/x-carriage/carriage.scad
extruder_source = src/extruder/extruder.scad
fanduct_source = src/fanduct/fanduct.scad
gear_source = src/gear/80T_gt2.scad
bridge_source = src/extruder/bridge.scad

all:$(output_dir)xcarriage.stl $(output_dir)extruders.stl $(output_dir)idlers.stl $(output_dir)beltclamps.stl $(output_dir)fanduct.stl $(output_dir)big_gear_80T.stl $(output_dir)bridge.stl $(output_dir)numbers.stl

$(output_dir)xcarriage.stl: $(main) $(configuration_file) $(carriage_source)
	$(oscad) -o $@ -D draw_complete=0 -D draw_carriage=1 -D draw_belt_clamps=0 -D draw_cooling_duct=0 -D draw_extruder=0 -D draw_idler=0 $(main)

$(output_dir)beltclamps.stl: $(main) $(configuration_file) $(carriage_source)
	$(oscad) -o $@ -D draw_complete=0 -D draw_carriage=0 -D draw_belt_clamps=1 -D draw_cooling_duct=0 -D draw_extruder=0 -D draw_idler=0 $(main)

$(output_dir)fanduct.stl: $(main) $(configuration_file) $(fanduct_source)
	$(oscad) -o $@ -D draw_complete=0 -D draw_carriage=0 -D draw_belt_clamps=0 -D draw_cooling_duct=1 -D draw_extruder=0 -D draw_idler=0 $(main)

$(output_dir)extruders.stl: $(main) $(configuration_file) $(extruder_source)
	$(oscad) -o $@ -D draw_complete=0 -D draw_carriage=0 -D draw_belt_clamps=0 -D draw_cooling_duct=0 -D draw_extruder=1 -D draw_idler=0 $(main)

$(output_dir)idlers.stl: $(main) $(configuration_file) $(extruder_source)
	$(oscad) -o $@ -D draw_complete=0 -D draw_carriage=0 -D draw_belt_clamps=0 -D draw_cooling_duct=0 -D draw_extruder=0 -D draw_idler=1 $(main)

$(output_dir)big_gear_80T.stl: $(gear_source)
	$(oscad) -o $@ $(gear_source)

$(output_dir)bridge.stl: $(main) $(bridge_source)
	$(oscad) -o $@ -D draw_complete=0 -D draw_carriage=0 -D draw_belt_clamps=0 -D draw_cooling_duct=0 -D draw_bridge=1 -D draw_idler=0 $(main)

$(output_dir)numbers.stl: $(main)
	$(oscad) -o $@ -D draw_complete=0 -D draw_carriage=0 -D draw_belt_clamps=0 -D draw_cooling_duct=0 -D draw_numbers=1 -D draw_idler=0 $(main)

clean:
	rm $(output_dir)*.stl
