extends Node2D

func spawn_villagers_in_village():
	for villager in VillagerManager.villagers:
		if villager["current_scene"] == VillagerManager.SceneType.VILLAGE and not villager["spawned"]:
			VillagerManager.spawn_villager(villager["name"], $Sorting/VillagerContainer)

func _input(event):
	if event.is_action_pressed("ui_cancel"):  # Check for the Escape key
		get_tree().quit()  # Close the game
		
func load_HUD():
	if not HUD.is_queued_for_deletion():
		# Add the HUD to the current scene
		add_child(HUD)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_HUD()
	spawn_villagers_in_village()
	var player_node = get_node("Sorting/MainPlayer")
	if player_node:
		player_node.set_player_position(GlobalPlayer.player_position.x,
		GlobalPlayer.player_position.y)
	
		# Setting player to not recieve input for 1 seconds
		player_node.input_enabled = false;
		await get_tree().create_timer(1).timeout
		player_node.input_enabled = true;
		
		player_node.move_speed = GlobalPlayer.move_speed;
		
	var canvas_node = get_node("CanvasModulate")
	canvas_node.time = GlobalEnviron.time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
