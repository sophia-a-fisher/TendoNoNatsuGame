extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var nav : NavigationAgent2D = $NavigationAgent2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer
var speed : float = 2000
var accel : float = 1
var move_finished : bool = true
var direction = Vector3()
@export var next_point_array: Array = [[]]
var next_point_positions: Array = [[]]
@export var next_time_array : PackedFloat32Array
var next_point_idx : int = 0
var next_time_idx : int = 0
var walk_anim_playing : bool = false
#var wait_time : float = 0
var created_patrol_pos : bool = false
var path_idx : int = 0

func _ready() -> void:
	# Starting the AI off idling
	anim_player.play("idle_left")
	
func _create_patrol_point_positions() -> void:
	var first_elem : bool = true
	for path_array in next_point_array:
		var position_array : Array = []
		if first_elem:
			position_array = next_point_positions[0]
			
		for path_group_id in path_array:
			var node = get_tree().get_nodes_in_group(path_group_id)[0]
			position_array.append(node.position)
			print(node.position)
		if first_elem:
			first_elem = false
		else:
			next_point_positions.append(position_array)
			
func _physics_process(delta: float) -> void:
	
	if !created_patrol_pos:
		# Creating a cached array of patrol point positions
		_create_patrol_point_positions()
		created_patrol_pos = true

	# Checking it we have finished moving to the point
	if (next_time_idx < next_time_array.size()):
		var past_move_time : bool
		var time_past = next_time_array[next_time_idx] * 600
		past_move_time = (int(GlobalEnviron.time) % 600) >= time_past
		if (past_move_time):
			move_finished = false	
	
	# Checking it is time to move to a new point
	if (!move_finished) and (next_point_idx < next_point_array.size()):
		_move_to_point(next_point_positions[next_point_idx], delta)
	
func _move_to_point(target_path : Array, delta: float) -> void:		
	#nav.target_position = target_position
	var next_position = target_path[path_idx]
	
	direction = next_position - global_position
	direction = direction.normalized()
	velocity = direction * speed * delta
	if abs(velocity.y) <= abs(velocity.x):
		if velocity.x < 0:
			anim_player.play("walk_left")
		elif velocity.x > 0:
			anim_player.play("walk_right")
	else:
		if velocity.y < 0:
			anim_player.play("walk_up")
		elif velocity.y > 0:
			anim_player.play("walk_down")
	
	move_and_slide()
	
	if (position - next_position).length() <= 1:
		path_idx += 1
		if path_idx >= target_path.size():
			move_finished = true
			next_point_idx += 1
			next_time_idx += 1
			path_idx = 0
			
			if (anim_player.current_animation == "walk_left") or (anim_player.current_animation == "walk_right"):
				if velocity.x < 0:
					anim_player.play("idle_left")
				elif velocity.x > 0:
					anim_player.play("idle_right")
			else:
				if velocity.y < 0:
					anim_player.play("idle_up")
				elif velocity.y > 0:
					anim_player.play("idle_down")
		
