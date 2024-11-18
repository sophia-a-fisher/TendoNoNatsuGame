extends Node
var time : float = 0.0
var time_paused : bool = false
var camera_zoom : float = 3.0
var current_scene_type : VillagerManager.SceneType = VillagerManager.SceneType.VILLAGE
var current_scene : String

# Defining the length of a day to be 10 minutes in real-life
@export var day_length : float = 10.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !time_paused:
		time += delta
