extends CharacterBody2D

@export var stroll_speed: float = 35
@export var walk_speed: float = 50
@export var sprint_speed: float = 70
@export var move_speed : float
@export var starting_dir : Vector2 = Vector2(0, .5)
@export var input_enabled : bool = true

@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer
@onready var state_machine = animation_tree.get("parameters/playback")

# Holds references to nearby NPCs
var nearby_villagers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the interaction area's signals
	$Interaction_Area.body_entered.connect(_on_area_body_entered)
	$Interaction_Area.body_exited.connect(_on_area_body_exited)
	move_speed = walk_speed
	update_animation_paramaters(starting_dir)
	DialogManager._set_player(self)
	
func _on_area_body_entered(body):
	# Check if the body has the "villager" tag
	if body.is_in_group("Villager"):
		nearby_villagers.append(body)

func _on_area_body_exited(body):
	# Remove the NPC from the list if it exits the interaction range
	if body.is_in_group("Villager"):
		nearby_villagers.erase(body)

# Function to check for NPC interaction when 'E' is pressed
func check_for_npc_interaction():
	if nearby_villagers.size() > 0:
		# Get the first NPC in range and start dialog with it
		var npc = nearby_villagers[0]  # Choose the first NPC in the list (or implement a selection logic if needed)
		if npc != null:
			var gen_key = DialogManager.get_generic_key(npc.dialog_prefix)  # Pass the NPC to the dialog manager
			if gen_key != "NA":
				npc.pause_movement()
				DialogManager.start_dialog(gen_key)
				
func unpause_npc():
	var npc = nearby_villagers[0]
	npc.movement_pause = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Only want to handle input if accepting
	if(input_enabled):
		var input_direction = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).normalized()
		
		update_animation_paramaters(input_direction)
		
		# Checking if started sprinting
		if Input.is_action_pressed('sprint'):
			if move_speed == walk_speed:
				move_speed = sprint_speed
				
		# Checking if stopping sprinting
		if Input.is_action_just_released("sprint"):
			if move_speed == sprint_speed:
				move_speed = walk_speed
			
		var velocity = input_direction * move_speed * delta * 100
		
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
		
func set_player_position(x_pos: int, y_pos: int):
	position.x = x_pos
	position.y = y_pos
	
	
	
