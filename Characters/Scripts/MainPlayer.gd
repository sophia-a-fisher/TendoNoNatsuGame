extends CharacterBody2D

@export var stroll_speed: float = 35
@export var walk_speed: float = 50
@export var sprint_speed: float = 70
@export var move_speed : float
@export var starting_dir : Vector2 = Vector2(0, .5)
@export var input_enabled : bool = true

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

#parameters/Idle/blend_position

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#print("Animation tree active" + str(animation_tree.active))
	move_speed = walk_speed
	update_animation_paramaters(starting_dir)

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
	
	
	
