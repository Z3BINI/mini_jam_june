extends StaticBody2D


var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player and (player.left_hooked or player.right_hooked):
		Engine.time_scale = 1

func _on_slow_time_check_body_entered(body : Player):
	if body.linear_velocity.y >= 0:
		Engine.time_scale = 0.15
		player = body

func _on_slow_time_check_body_exited(body : Player):
	if Engine.time_scale < 1:
		Engine.time_scale = 1
		player = null

func _on_grappable_4_area_entered(area : GrapplePoint):
	var pl = get_tree().get_first_node_in_group("player")
	pl.disable_side(area.current_side)
