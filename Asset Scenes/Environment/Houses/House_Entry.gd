extends Area2D

@export var player_scene: PackedScene = preload("res://Characters/MainPlayer.tscn")
@export var spawn_location: Vector2 = Vector2(300, 400) 

# Called when the node enters the scene tree for the first time.
func _ready():
	#spawn_player(spawn_location)
	pass

#func spawn_player(position: Vector2):
	#var sorting_node = $Sorting  # Reference the "Sorting" node
	#if sorting_node:
	#	var player = player_scene.instantiate()  # Create an instance of the player
	#	sorting_node.add_child(player)  # Add the player to the "Sorting" node
	#	player.position = position  # Set the player's position
	#	player.y_sort_enabled = true
	#	player.z_index = 0
		
		# Add RemoteTransform2D to the player
	#	var remote_transform = RemoteTransform2D.new()  # Create the RemoteTransform2D instance
	#	player.add_child(remote_transform)  # Add it as a child of the player   
	# Example of setting the RemoteTransform2D properties
	#	remote_transform.remote_path = get_node("Camera2D").get_path()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		switchToHouseInterior(body)
	
func switchToHouseInterior(body: Node2D) -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	var villageLevel = get_parent().get_parent().get_parent().get_parent()
	GlobalEnviron.time = villageLevel.get_node("CanvasModulate").time
	
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
