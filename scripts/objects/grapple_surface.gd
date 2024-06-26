class_name GrappleSurface extends StaticBody2D

signal slow_mo(amount : float, time : float)
signal normal_mo()

@export var MAX_SLOW_MO : float = 0.15
@export var MAX_SLOW_TIME : float = 3

var lava : Lava

# Called when the node enters the scene tree for the first time.
func _ready():
	lava = get_tree().get_first_node_in_group("lava")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func _on_slow_time_check_body_entered(body : Player):
	if (body.linear_velocity.y >= 0 and 
	body.slow_motioned == false and 
	(!body.left_hooked and !body.right_hooked) and 
	(body.global_position - lava.global_position).length() < 3250): 
		slow_mo.emit(MAX_SLOW_MO, MAX_SLOW_TIME)

func _on_slow_time_check_body_exited(body : Player):
	if body.slow_motioned == true:
		normal_mo.emit()
