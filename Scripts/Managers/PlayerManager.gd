extends Node
var player_position =  Vector2(0, 0)
var move_speed : float = 50
var inside_structure : bool = false

@export var stroll_speed: float = 50
@export var walk_speed: float = 70
@export var sprint_speed: float = 100
	
# Called when the player has entered a house via doorway to store player position
func update_entering_structure(body: Node2D):
	# Slightly lowering the save player position in the map
	player_position = body.position
	player_position.y += 10;
	move_speed = stroll_speed
	inside_structure = true
	
# Called when the player has entered a house via doorway to store player position
func update_exiting_structure(body: Node2D):
	# Preventing the player from moving
	body.input_enabled = false;
	move_speed = stroll_speed
	inside_structure = false
	
# TODO add other data transfers from the persistent player to instance
func update_player_instance(player: Node2D):
	player.move_speed = move_speed;
	if !inside_structure:
		player.position = player_position
	
# Sets up the player when a scene has been loaded
func setup_player(player: Node2D):
	input_pause(player)
	update_player_instance(player)
	
# Pauses player input
func input_pause(player_node: Node2D) -> void:
	player_node.input_enabled = false;
	await get_tree().create_timer(1).timeout
	player_node.input_enabled = true;
