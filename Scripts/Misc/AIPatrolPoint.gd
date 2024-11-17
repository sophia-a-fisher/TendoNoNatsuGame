# Represents a placeable AI patrol point

@tool 
extends Node2D

@export var group_id : String

func _ready() -> void:
	_add_group_id()
		
# Sets up a label to show the patrol point id in editor
func _add_group_id() -> void:
	if Engine.is_editor_hint():
		add_to_group(group_id)
		$Label.text = group_id
	else:
		add_to_group(group_id)
		visible = false
