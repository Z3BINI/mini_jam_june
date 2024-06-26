extends CanvasLayer

var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Distance.text = str(snapped(abs(player.global_position.y * 0.1), 0.01))
