# Represents a shakeable vegetation

extends Area2D
	
func _begin_shake() -> void:
	$AnimationPlayer.play("shake")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") or body.is_in_group("Villager"):
		_begin_shake()
