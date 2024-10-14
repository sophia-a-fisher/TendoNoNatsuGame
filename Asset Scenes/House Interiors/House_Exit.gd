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
		
func switchToHouseExterior(body: Node2D) -> void:
	
	body.set_velocity(Vector2(0,0))
	if is_in_group("House1_Exit"):
		body.set_player_position(-10,-99)
	elif is_in_group("House2_Exit"):
		body.set_player_position(-615,-142)
	elif is_in_group("House3_Exit"):
		body.set_player_position(-1007,-238)
	elif is_in_group("House4_Exit"):
		body.set_player_position(-1041,316)
	elif is_in_group("House5_Exit"):
		body.set_player_position(-1052,667)
	elif is_in_group("House6_Exit"):
		body.set_player_position(-660,799)
	elif is_in_group("House7_Exit"):
		body.set_player_position(-430,948)
	elif is_in_group("House8_Exit"):
		body.set_player_position(-264,1022)
	elif is_in_group("House9_Exit"):
		body.set_player_position(-35,1115)
	elif is_in_group("House10_Exit"):
		body.set_player_position(339,-88)
	elif is_in_group("House11_Exit"):
		body.set_player_position(249,111)
	elif is_in_group("House12_Exit"):
		body.set_player_position(409,384)
	elif is_in_group("House13_Exit"):
		body.set_player_position(-619,152)
	elif is_in_group("House14_Exit"):
		body.set_player_position(-530,415)
	elif is_in_group("House15_Exit"):
		body.set_player_position(-545,548)
	elif is_in_group("House16_Exit"):
		body.set_player_position(-5,399)
	elif is_in_group("House17_Exit"):
		body.set_player_position(42,648)
		
	get_tree().change_scene_to_file('res://Levels/VillageLevel.tscn')
