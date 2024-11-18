extends CharacterBody2D

var move_speed : float
var starting_dir : Vector2 = Vector2(0, .5)
var input_enabled : bool = true

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

# Holds references to nearby NPCs
var nearby_villagers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the interaction area's signals
	move_speed = PlayerManager.walk_speed
	update_animation_paramaters(starting_dir)
	DialogManager.set_player(self)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Only want to handle input if accepting
	handle_movement()
	handle_move_speed_change()
	
func handle_move_speed_change() -> void:
	# Checking if started sprinting
	if Input.is_action_pressed('sprint'):
		if move_speed == PlayerManager.walk_speed:
			move_speed = PlayerManager.sprint_speed
			
	# Checking if stopping sprinting
	if Input.is_action_just_released("sprint"):
		if move_speed == PlayerManager.sprint_speed:
			move_speed = PlayerManager.walk_speed
		
func handle_movement() -> void:
	if(input_enabled):
		var input_direction = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")).normalized()
		
		update_animation_paramaters(input_direction)
		var velocity = input_direction * move_speed
		
		# Updating player position according to velocity
		set_velocity(velocity)
		move_and_slide()
		pick_new_state(velocity)
	
func update_animation_paramaters(move_input: Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
	
func pick_new_state(velocity: Vector2):
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
	
# Function to check for NPC interaction when 'E' is pressed
func check_for_npc_interaction() -> bool:
	if nearby_villagers.size() > 0:
		DialogManager.npc = nearby_villagers[0] 
		return true
	return false

func _on_interaction_area_body_entered(body: Node2D) -> void:
	# Check if the body has the "villager" tag
	if body.is_in_group("Villager"):
		nearby_villagers.append(body)

func _on_interaction_area_body_exited(body: Node2D) -> void:
	# Remove the NPC from the list if it exits the interaction range
	if body.is_in_group("Villager"):
		nearby_villagers.erase(body)
