extends PathFollow2D

var speed = 2.5
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _physics_process(delta):
	move(delta)

func move(delta):
	set_offset(get_offset()+speed+delta)
# Called when the node enters the scene tree for the first time.

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
