extends Node2D

@onready var camera_2d : Camera2D = $Camera2D

var player : Player

var slow_time : bool = false
var slow_amount : float

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera_2d.global_position.y = player.global_position.y
	match slow_time:
		true:
			if Engine.time_scale != slow_amount:
				Engine.time_scale = slow_amount
		false:
			if Engine.time_scale < 1:
				Engine.time_scale = move_toward(Engine.time_scale, 1, 5 * delta)


func _on_surface_slow_mo(amount, time):
	slow_time = true
	player.slow_motioned = true
	slow_amount = amount
	
func _on_surface_normal_mo():
	player.slow_motioned = false
	slow_time = false
