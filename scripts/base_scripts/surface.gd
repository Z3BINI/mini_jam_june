class_name Surface extends Node

signal slow_mo(amount : float, time : float)
signal normal_mo()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_slow_time_check_body_entered(body : Player):
	if body.linear_velocity.y >= 0 and body.slow_motioned == false: 
		slow_mo.emit(MAX_SLOW_MO, MAX_SLOW_TIME)

func _on_slow_time_check_body_exited(body : Player):
	if body.slow_motioned == true:
		normal_mo.emit()
