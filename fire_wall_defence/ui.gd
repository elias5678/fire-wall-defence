extends CanvasLayer
var tower_rang=320
func set_tower_preview(tower_type,mouse_position):
	var drag_tower = load("res://turret/"+tower_type+".tscn").instance()
	drag_tower.set_name("Dragtower")
	drag_tower.modulate =Color("ad54ff3c")
	
	var range_prit=Sprite.new()
	range_prit.position=Vector2(32,32)
	var scaling=Data.tower_data[tower_type]["range"]/600.0
	range_prit.scale=Vector2(scaling,scaling)
	var texture = load("res://PNG/range_overlay.png")
	range_prit.texture=texture
	range_prit.modulate=Color("ad54ff3c")
	
	
	var control =Control.new()
	control.add_child(drag_tower,true)
	control.add_child(range_prit,true)
	control.rect_position =mouse_position
	control.set_name("towerpreview")
	add_child(control,true)
	move_child(get_node("towerpreview"),0)
	
func update_tower_preview(new_position,color):
		get_node("towerpreview").rect_position=new_position
		if get_node("towerpreview/Dragtower").modulate!=Color(color):
			get_node("towerpreview/Dragtower").modulate=Color(color)
			get_node("towerpreview/Sprite").modulate=Color(color)
