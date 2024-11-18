# Represents a house exiting collision volume

extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameManager.current_scene_type = VillagerManager.SceneType.VILLAGE
		VillagerManager.reset_villager_spawned()
		PlayerManager.update_exiting_structure(body)
		switch_to_house_exterior(body)
		
func switch_to_house_exterior(body: Node2D) -> void:	
	# Playing transition animation and scene switching
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	GameManager.current_scene = 'res://Levels/VillageLevel.tscn'
	get_tree().change_scene_to_file(GameManager.current_scene)
