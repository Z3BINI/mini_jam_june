extends StaticBody2D

var lava : Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	lava = get_tree().get_first_node_in_group("lava")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if global_position.y > lava.global_position.y + 55:
		queue_free()
