class_name Lava extends Area2D

signal player_died

var lava_bubbling : AudioStream = load("res://assets/audio/lava.mp3")

@export var RISE_SPEED : float = 25

var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	AudioManager.play_sfx(lava_bubbling, self, 0)

func _physics_process(delta):
	if player:
		global_position.x = player.global_position.x
	
	global_position.y -= RISE_SPEED * delta

func _on_body_entered(body : Player):
	player_died.emit()
	body.died = true
