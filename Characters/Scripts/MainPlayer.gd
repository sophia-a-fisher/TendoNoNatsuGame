extends CharacterBody2D

@export var move_speed : float = 75
@export var starting_dir : Vector2 = Vector2(0, .5)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

#parameters/Idle/blend_position

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Animation tree active" + str(animation_tree.active))
	update_animation_paramaters(starting_dir)
	#animation_tree.set("parameters/Idle/blend_position", starting_dir)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	update_animation_paramaters(input_direction)
	
	var velocity = input_direction * move_speed * delta * 100
	#print("velocity" + str(Input.get_action_strength("ui_right")))
	
	set_velocity(velocity)
	move_and_slide()
	
	pick_new_state(velocity)
	
func update_animation_paramaters(move_input: Vector2):
	if(move_input != Vector2.ZERO):
		#print("x" + str(move_input.x))
		#print("y" + str(move_input.y))
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
	
func pick_new_state(velocity: Vector2):
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
	
	
	
