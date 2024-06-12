extends Node2D

@onready var camera_2d : Camera2D = $Camera2D

var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera_2d.global_position.y = player.global_position.y
