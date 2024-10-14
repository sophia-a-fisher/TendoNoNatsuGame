extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		switchToHouseInterior()
	
func switchToHouseInterior() -> void:
	if is_in_group("House1_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house1_interior.tscn')
	elif is_in_group("House2_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house2_interior.tscn')
	elif is_in_group("House3_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house3_interior.tscn')
	elif is_in_group("House4_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house4_interior.tscn')
	elif is_in_group("House5_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house5_interior.tscn')
	elif is_in_group("House6_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house6_interior.tscn')
	elif is_in_group("House7_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house7_interior.tscn')
	elif is_in_group("House8_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house8_interior.tscn')
	elif is_in_group("House9_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house9_interior.tscn')
	elif is_in_group("House10_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house10_interior.tscn')
	elif is_in_group("House11_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house11_interior.tscn')
	elif is_in_group("House12_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house12_interior.tscn')
	elif is_in_group("House13_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house13_interior.tscn')
	elif is_in_group("House14_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house14_interior.tscn')
	elif is_in_group("House15_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house15_interior.tscn')
	elif is_in_group("House16_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house16_interior.tscn')
	elif is_in_group("House17_Entry"):
		get_tree().change_scene_to_file('res://Asset Scenes/House Interiors/house17_interior.tscn')
