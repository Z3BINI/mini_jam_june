extends Node2D

var surface_spawn : PackedScene = load("res://scenes/objects/surface_spawn.tscn")

var platform_holder : Node
var spawn_positions : Array
var lava : Area2D

var have_spawned_neighbour : bool = false

@onready var surfaces = $Surfaces

# Called when the node enters the scene tree for the first time.
func _ready():
	lava = get_tree().get_first_node_in_group("lava")
	platform_holder = get_tree().get_first_node_in_group("platforms")
	spawn_positions = surfaces.get_children()
	
	randomize_spawn_pos()
	fill_spawn_pos()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.y - 400 > lava.global_position.y:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered():
	if !have_spawned_neighbour:
		var new_surface = surface_spawn.instantiate()
		new_surface.global_position.y = global_position.y - 960
		
		platform_holder.add_child(new_surface)
		
		have_spawned_neighbour = true
	

func randomize_spawn_pos():
	
	
	for spawn in spawn_positions:
		spawn.position += Vector2(randf_range(-100, 100), randf_range(-100, 100))

func fill_spawn_pos():
	
	for spawn in spawn_positions:
		var grappable_surface = preload("res://scenes/objects/grapple_surface.tscn").instantiate()
		grappable_surface.rotate(randi_range(0, 360))
		spawn.add_child(grappable_surface)
