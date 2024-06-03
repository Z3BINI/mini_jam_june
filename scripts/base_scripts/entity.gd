class_name Entity extends CharacterBody2D

@export var MAX_SPEED : float
@export var ACCEL : float
@export var DECEL : float

var can_move : bool = true
var current_speed : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	pass
	
func _physics_process(_delta : float) -> void:
	move_and_slide()

func move(direction : Vector2) -> void:
	if !can_move: return
	
	if !(direction.is_normalized()):
		direction = direction.normalized()
		
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCEL)
