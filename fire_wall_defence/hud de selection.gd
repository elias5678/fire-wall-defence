extends Node2D


var map_node
var bmap_node
var build_mode=false
var build_tiles
var build_valide=false
var build_location
var build_type

func _ready():
	map_node=get_node("TileMap") 
	for i in get_tree().get_nodes_in_group("building_barre"):
		i.connect("pressed",self,"initiate_build_mode", [i.get_name()])

func _process(delta):
	if build_mode:
		update_tower_preview()
	
func _unhandled_input(event):
	if event.is_action_released("ui_cancel")and build_mode==true:
		cancel_build_mode()
	if event.is_action_released("ui_accept")and build_mode==true:
		verify_and_build()
		cancel_build_mode()
	
func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type=tower_type 
	build_mode =true
	get_node("ui").set_tower_preview(build_type,get_global_mouse_position())
	
func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile  = map_node.get_node("TileMap2").world_to_map(mouse_position)
	var tile_position = map_node.get_node("TileMap2").map_to_world(current_tile)
	
	if map_node.get_node("TileMap2").get_cellv(current_tile) == -1:
		get_node("ui").update_tower_preview(tile_position,"adff4545")
		build_valide = false
		
	
	else:
		get_node("ui").update_tower_preview(tile_position,"ad54ff3c")
		build_valide = true
		build_location=tile_position
		build_tiles=current_tile
		
func cancel_build_mode():
	build_mode=false
	build_valide=false
	get_node("ui/towerpreview").free()
	
func verify_and_build():
	if build_valide:
		var new_tower = load("res://turret/"+build_type+".tscn").instance()
		new_tower.position=build_location
		map_node.get_node("tourelles").add_child(new_tower,true)
		map_node.get_node("TileMap2").set_cellv(build_tiles,50)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
