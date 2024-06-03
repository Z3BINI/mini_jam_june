class_name Entity extends CharacterBody2D

@export var MAX_SPEED : float
@export var ACCEL : float
@export var DECEL : float

const GRAVITY : float = 500

var can_move : bool = true
var current_speed : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	if !is_on_floor():
		fall(delta)
	
func _physics_process(_delta : float) -> void:
	move_and_slide()

func move(horizontal_direction : float, delta : float) -> void:
	if !can_move: return
	velocity.x = move_toward(velocity.x, horizontal_direction * MAX_SPEED, ACCEL * delta)

func stop(type : String, delta : float):
	match type:
		"normal":
			velocity.x = move_toward(velocity.x, 0, DECEL * delta)
		"forced":
			velocity.x = 0
		"_":
			print("Wrong Entity stop(type : String) type request!")
			
func fall(delta : float):
	velocity.y += GRAVITY * delta
