extends Node
var player_position =  Vector2(0, 0)
var move_speed : float = 50
var stroll_speed: float = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called when the player has entered a house via doorway to store player position
func update_position_doorway(body: Node2D):
	player_position = body.position
	player_position.y += 10;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
