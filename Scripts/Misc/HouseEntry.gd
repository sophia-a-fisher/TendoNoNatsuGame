# Represents the house entering collision volume

extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameManager.current_scene_type = VillagerManager.SceneType.HOME
		VillagerManager.reset_villager_spawned()
		PlayerManager.update_entering_structure(body) 
		switch_to_house_interior(body)
	
func switch_to_house_interior(body: Node2D) -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	scene_transition()
	
func scene_transition() -> void:
	if is_in_group("House1_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house1_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house1_interior.tscn')
	elif is_in_group("House2_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house2_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house2_interior.tscn')
	elif is_in_group("House3_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house3_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house3_interior.tscn')
	elif is_in_group("House4_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house4_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house4_interior.tscn')
	elif is_in_group("House5_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house5_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house5_interior.tscn')
	elif is_in_group("House6_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house6_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house6_interior.tscn')
	elif is_in_group("House7_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house7_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house7_interior.tscn')
	elif is_in_group("House8_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house8_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house8_interior.tscn')
	elif is_in_group("House9_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house9_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house9_interior.tscn')
	elif is_in_group("House10_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house10_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house10_interior.tscn')
	elif is_in_group("House11_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house11_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house11_interior.tscn')
	elif is_in_group("House12_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house12_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house12_interior.tscn')
	elif is_in_group("House13_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house13_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house13_interior.tscn')
	elif is_in_group("House14_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house14_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house14_interior.tscn')
	elif is_in_group("House15_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house15_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house15_interior.tscn')
	elif is_in_group("House16_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house16_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house16_interior.tscn')
	elif is_in_group("House17_Entry"):
		GameManager.current_scene = 'res://Asset Scenes/House Interiors/house17_interior.tscn' 
		#get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house17_interior.tscn')
	get_tree().change_scene_to_file(GameManager.current_scene)
