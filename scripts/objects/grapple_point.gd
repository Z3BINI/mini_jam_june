class_name GrapplePoint extends Area2D

@export var TRAVEL_SPEED : float = 250
@export var MAX_TRAVEL_DISTANCE : float = 400

enum GrappleStatus {OUTBOUND, RETURNING, HOOKED}

var shoot_dir : Vector2
var current_side : String

var current_status : GrappleStatus
var distance_travelled : float = 0  # Keep track of grapple rope "length" to respect MAX_TRAVEL_DISTANCE and current attachment distance.

var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	if player:
		player.detach.connect(_on_player_detach)
	
	current_status = GrappleStatus.OUTBOUND  # On spawn -> shoot!

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	match current_status:
		GrappleStatus.OUTBOUND:
			global_position += shoot_dir * TRAVEL_SPEED * delta
			distance_travelled += TRAVEL_SPEED * delta
			
			match current_side:  # To keep correct grapple & arm connection
				"left":
					$TextureRect.global_position = player.left_grapple_spawn.global_position
				"right":
					$TextureRect.global_position = player.right_grapple_spawn.global_position
			
			$TextureRect.size.x += TRAVEL_SPEED * delta
			
		GrappleStatus.RETURNING:  # Either hasn't hit a surface or player is detaching
			var return_direction : Vector2
			
			match current_side:  # To keep correct grapple return position/direction
				"left":
					return_direction = (player.left_grapple_spawn.global_position - global_position).normalized()
					
					$TextureRect.global_position = player.left_grapple_spawn.global_position
				"right":
					return_direction = (player.right_grapple_spawn.global_position - global_position).normalized()
					
					$TextureRect.global_position = player.right_grapple_spawn.global_position
			
			global_position += return_direction * (TRAVEL_SPEED * 2) * delta
			distance_travelled -= (TRAVEL_SPEED * 2) * delta
			
			$TextureRect.size.x -= (TRAVEL_SPEED * 2) * delta
			
		GrappleStatus.HOOKED:  # Update the red texture based on distance to object.
			if current_side == "left":
				$TextureRect.size.x = player.left_grapple_spawn.global_position.distance_to(player.left_thing_to_stick.global_position)
			elif current_side == "right":
				$TextureRect.size.x = player.right_grapple_spawn.global_position.distance_to(player.right_thing_to_stick.global_position)
	
	# The logic that checks if the grapple has reached its max length
	# also responsible for eliminating the grapple instance and reseting
	# the player's cooldown to shoot again (..._ready : bool)
	if distance_travelled > MAX_TRAVEL_DISTANCE:
		if current_status == GrappleStatus.OUTBOUND:
			current_status = GrappleStatus.RETURNING
	elif distance_travelled <= 0:
		if current_side == "left":
			player.left_ready = true
		else:
			player.right_ready = true
		queue_free()
		
func _on_area_entered(area):  # The signal that attaches grapple to surface
	if current_status == GrappleStatus.OUTBOUND:
		current_status = GrappleStatus.HOOKED  # and this script takes care of its appearance
		player.attach.emit(area.get_parent(), distance_travelled, current_side)  # player takes care of the attachment

func _on_player_detach(side : String):
	if current_side == side:
		current_status = GrappleStatus.RETURNING
