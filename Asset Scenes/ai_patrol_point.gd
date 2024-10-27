
@tool 
extends Node2D

@export var group_id : String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		add_to_group(group_id)
		$Label.text = group_id
	else:
		add_to_group(group_id)
		visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
