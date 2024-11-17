extends Node
var time : float = 0.0
var time_paused : bool = false
var camera_zoom : float = 3.0
# Defining the length of a day to be 10 minutes in real-life
@export var day_length : float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !time_paused:
		time += delta
