class_name Player extends Entity


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta : float) -> void:
	
	var input_direction : float = Input.get_axis("move_left", "move_right")
	
	if input_direction:
		move(input_direction, delta)
	else:
		if velocity.x != 0: 
			stop("normal", delta)
		
	move_and_slide()
