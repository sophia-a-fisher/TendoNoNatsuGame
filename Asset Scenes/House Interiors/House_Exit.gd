extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		switchToHouseExterior(body)
		
func reset_villager_states():
	for villager in VillagerManager.villagers:
		if villager["current_scene"] == VillagerManager.SceneType.HOME and villager["spawned"]:
			villager["spawned"] = false
			#print(villager["name"], "has been marked as not spawned.")
		
func switchToHouseExterior(body: Node2D) -> void:
	# TODO design better
	reset_villager_states()
	
	# Preventing the player from moving
	body.input_enabled = false;
	GlobalPlayer.move_speed = GlobalPlayer.stroll_speed
	
	GlobalEnviron.time = get_parent().time
	
	#if is_in_group("House1_Exit"):
		#GlobalPlayer.player_position = Vector2(-10, -99)
	#elif is_in_group("House2_Exit"):
		#GlobalPlayer.player_position = Vector2(-615,-142)
	#elif is_in_group("House3_Exit"):
		#GlobalPlayer.player_position = Vector2(-1007,-238)
	#elif is_in_group("House4_Exit"):
		#GlobalPlayer.player_position = Vector2(-1041,316)
	#elif is_in_group("House5_Exit"):
		#GlobalPlayer.player_position = Vector2(-1052,667)
	#elif is_in_group("House6_Exit"):
		#GlobalPlayer.player_position = Vector2(-660,799)
	#elif is_in_group("House7_Exit"):
		#GlobalPlayer.player_position = Vector2(-430,948)
	#elif is_in_group("House8_Exit"):
		#GlobalPlayer.player_position = Vector2(-264,1022)
	#elif is_in_group("House9_Exit"):
		#GlobalPlayer.player_position = Vector2(-35,1115)
	#elif is_in_group("House10_Exit"):
		#GlobalPlayer.player_position = Vector2(339,-88)
	#elif is_in_group("House11_Exit"):
		#GlobalPlayer.player_position = Vector2(249,111)
	#elif is_in_group("House12_Exit"):
		#GlobalPlayer.player_position = Vector2(409,384)
	#elif is_in_group("House13_Exit"):
		#GlobalPlayer.player_position = Vector2(-619,152)
	#elif is_in_group("House14_Exit"):
		#GlobalPlayer.player_position = Vector2(-530,415)
	#elif is_in_group("House15_Exit"):
		#GlobalPlayer.player_position = Vector2(-545,548)
	#elif is_in_group("House16_Exit"):
		#GlobalPlayer.player_position = Vector2(-5,399)
	#elif is_in_group("House17_Exit"):
		#GlobalPlayer.player_position = Vector2(42,648)
		
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	
	get_tree().change_scene_to_file('res://Levels/VillageLevel.tscn')
	
	
	
	
	
