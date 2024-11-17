# Represents a house exiting collision volume

extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		switch_to_house_exterior(body)
		
# Updating all villager states to not spawned
func reset_villager_states():
	for villager in VillagerManager.villagers:
		if villager["current_scene"] == VillagerManager.SceneType.HOME and villager["spawned"]:
			villager["spawned"] = false
		
func switch_to_house_exterior(body: Node2D) -> void:
	reset_villager_states()
	
	# Preventing the player from moving
	body.input_enabled = false;
	GlobalPlayer.move_speed = GlobalPlayer.stroll_speed
	
	# Playing transition animation and scene switching
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file('res://Levels/VillageLevel.tscn')
