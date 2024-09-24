extends Area2D

var MAX_SHAKE : float = 20;
var PI : float = 3.14;
#var first_frame: bool = true;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#first_frame = false;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _begin_shake() -> void:
	#_shake(MAX_SHAKE)
	$AnimationPlayer.play("shake")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_begin_shake()
	
	
