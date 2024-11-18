extends CharacterBody2D

var move_finished : bool = true
var direction = Vector3()

@export var dialog_prefix : String = ""
@export var next_point_array: Array = [[]]
@export var next_time_array : PackedFloat32Array
var next_point_positions: Array = [[]]

var next_point_idx : int = 0
var next_time_idx : int = 0
var path_idx : int = 0

var created_patrol_pos : bool = false
var movement_pause : bool = false

# temporary variable to get villager spawning correctly
var first_move: bool = true

@onready var nav : NavigationAgent2D = $NavigationAgent2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer

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
#			For now we will ignore if we are in the house interior
			if get_tree().get_nodes_in_group(path_group_id):
				var node = get_tree().get_nodes_in_group(path_group_id)[0]
				position_array.append(node.position)
		if first_elem:
			first_elem = false
		else:
			next_point_positions.append(position_array)
			
func _physics_process(_delta: float) -> void:
	if not movement_pause:
		# TODO move this to ready when villagerManager done
		if !created_patrol_pos:
			# Creating a cached array of patrol point positions
			_create_patrol_point_positions()
			created_patrol_pos = true

		handle_new_target_path()
		
		# Checking it is time to move to a new point
		if (!move_finished) and (next_point_idx < next_point_array.size()):
			_move_to_point(next_point_positions[next_point_idx])
			
func handle_new_target_path() -> void:
	if (next_time_idx < next_time_array.size()):
		var cur_time = next_time_array[next_time_idx] * 600
		var past_move_time = (int(GameManager.time) % 600) >= cur_time
		# Checking if its time to start moving along a new path
		if (past_move_time):
			move_finished = false	
			
func handle_reached_point(target_path : Array) -> void:
	if target_path.size() > 0:
		var next_position = target_path[path_idx]
		# Checking we have reached the target point
		if (position - next_position).length() <= 1:
			path_idx += 1
			# Checking we had reached the final path destination
			if path_idx >= target_path.size():
				handle_move_finished()
			
func pause_movement():
	movement_pause = true
	if anim_player.current_animation == "walk_left":
		anim_player.play("idle_left")
	elif anim_player.current_animation == "walk_right":
		anim_player.play("idle_right") 
	elif anim_player.current_animation == "walk_up":
		anim_player.play("idle_up") 
	elif anim_player.current_animation == "walk_down":
		anim_player.play("idle_down") 
		
func unpause_movement():
	movement_pause = false
	
func _move_to_point(target_path : Array) -> void:		
	# TODO get rid of, temporary fix to get villagers spawning into village level initially
	if first_move:
		if (target_path.size() == 0):
			VillagerManager.update_villager_state(dialog_prefix, VillagerManager.SceneType.VILLAGE)
			queue_free()
			return
		first_move = false
	
	if path_idx < target_path.size():
		var next_position = target_path[path_idx]
		direction = next_position - global_position
		direction = direction.normalized()
		velocity = direction * VillagerManager.speed
		play_walk_anim()
		move_and_slide()
		handle_reached_point(next_point_positions[next_point_idx])
	else:
		handle_move_finished()
	
func play_walk_anim() -> void:
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
			
func handle_move_finished() -> void:
	move_finished = true
	next_point_idx += 1
	next_time_idx += 1
	path_idx = 0
	
	var anim = anim_player.current_animation
	if (anim == "walk_left") or (anim == "walk_right"):
		if velocity.x < 0:
			anim_player.play("idle_left")
		elif velocity.x > 0:
			anim_player.play("idle_right")
	else:
		if velocity.y < 0:
			anim_player.play("idle_up")
		elif velocity.y > 0:
			anim_player.play("idle_down")
