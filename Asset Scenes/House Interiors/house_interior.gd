extends Node2D

var time : float = 0.0

func _input(event):
	if event.is_action_pressed("ui_cancel"):  # Check for the Escape key
		get_tree().quit()  # Close the game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_node = get_node("Sorting/MainPlayer")
	if player_node:
		# Setting player to not recieve input for 1 seconds
		player_node.input_enabled = false;
		await get_tree().create_timer(1).timeout
		player_node.input_enabled = true;
		player_node.move_speed = GlobalPlayer.move_speed;
	time = GlobalEnviron.time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta 
