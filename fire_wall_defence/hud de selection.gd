extends Node2D


var map_node
var bmap_node
var build_mode=false
var build_tiles
var build_valide=false
var build_location
var build_type
var current_wave =0
var enemies_in_wave=0

func _ready():
	map_node=get_node("TileMap") 
	for i in get_tree().get_nodes_in_group("building_barre"):
		i.connect("pressed",self,"initiate_build_mode", [i.get_name()])
		
		start_next_wave()

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
		get_node("ui").update_tower_preview(tile_position,"ad54ff3c")
		
		build_valide = true
		build_location = tile_position
		build_tiles=current_tile
	
	else:
		get_node("ui").update_tower_preview(tile_position,"adff4545")
		build_valide = false
		
func cancel_build_mode():
	build_mode=false
	build_valide=false
	get_node("ui/towerpreview").free()
	
func verify_and_build():
	if build_valide:
		var new_tower = load("res://turret/"+ build_type +".tscn").instance()
		new_tower.position = build_location
		new_tower.build = true
		new_tower.build_name= build_type
		map_node.get_node("tourelles").add_child(new_tower,true)
		map_node.get_node("TileMap2").set_cellv(build_tiles,50)

func start_next_wave():
	var wave_data= retrieve_wave_data()
	yield(get_tree().create_timer(0.1),"timeout")
	spawn_wave(wave_data)
func retrieve_wave_data():
		var wave_data = [["xénon",0.7],["xénon",0.2]]
		current_wave += 1
		enemies_in_wave = wave_data.size()
		return wave_data
func spawn_wave(wave_data):
	for i in wave_data:
		var new_enemy = load("res://ennemi/" + i[0] + ".tscn").instance()
		map_node.get_node("Path").add_child(new_enemy,true)
		yield(get_tree().create_timer(i[1]),"timeout")


func _on_pause_play_pressed():
	if get_tree().is_paused():
		
		get_tree().paused=false
	else:
		get_tree().paused=true
