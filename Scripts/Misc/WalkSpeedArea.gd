# Represents the speed transition volumes for the player

extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.move_speed = PlayerManager.stroll_speed
		
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.move_speed = PlayerManager.walk_speed;
