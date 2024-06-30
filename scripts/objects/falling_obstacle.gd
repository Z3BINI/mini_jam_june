extends RigidBody2D

var hit_sfx : AudioStream = load("res://assets/audio/dmg_hit.mp3")
var player_hit_sfx : AudioStream = load("res://assets/audio/player_hit.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body : Player):
	AudioManager.play_sfx(hit_sfx, self, 0)
	AudioManager.play_sfx(player_hit_sfx, self, 0)
