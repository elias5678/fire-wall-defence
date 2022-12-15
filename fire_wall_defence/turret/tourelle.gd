extends Node2D

var ennemi_ar=[]
var build =false
var ennemi
var build_name 
func _ready():
	
	if build:
		self.get_node("Range/colition").get_shape().radius=0.5 * Data.tower_data[build_name]["range"]

func _on_Range_body_entered(body):
	ennemi_ar.append(body.get_parent())


func _on_Range_body_exited(body):
	ennemi_ar.erase(body.get_parent())

func _physics_process(delta):
	if ennemi_ar.size()!=0 and build:
		select_ennemie()
		turn();
	else:
		ennemi=null	
func select_ennemie():
	var ennemie_progress=[]
	for i in ennemi_ar:
		ennemie_progress.append(i.offset)
	var max_offset =ennemie_progress.max()
	var ennemi_index =ennemie_progress.find(max_offset)
	ennemi = ennemi_ar[ennemi_index]
func turn():
#	var enemy_position = get_global_mouse_position()
	# var look_position=Vector2(-enemy_position.y,enemy_position.x)
	get_node("tourel").look_at(ennemi.position)
