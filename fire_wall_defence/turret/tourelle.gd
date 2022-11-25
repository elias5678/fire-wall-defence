extends Node2D


func _physics_process(delta):
	turn();
func turn():
	var enemy_position = get_global_mouse_position()
	# var look_position=Vector2(-enemy_position.y,enemy_position.x)
	get_node("tourel").look_at(enemy_position)
