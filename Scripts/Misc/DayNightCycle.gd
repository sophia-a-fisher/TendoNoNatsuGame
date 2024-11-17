# Represents the canvas coloration layer

extends CanvasModulate

var sin_coefficient : float
@export var gradient:GradientTexture1D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sin_coefficient = GlobalEnviron.day_length * (PI/3000)

func _process(delta: float) -> void:
	_update_canvas_coloration()
		
# Updating the canvas color occording to the time
func _update_canvas_coloration() -> void:
	if not GlobalEnviron.time_paused:
		var value = (sin(sin_coefficient * (GlobalEnviron.time - PI/2)) + 1.0) / 2.0
		self.color = gradient.gradient.sample(value)
