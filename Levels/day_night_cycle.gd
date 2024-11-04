extends CanvasModulate

var time : float = 0.0
@export var day_length : float = 10.0
var sin_coefficient : float
@export var gradient:GradientTexture1D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sin_coefficient = day_length * (PI/3000)
	time = GlobalEnviron.time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not GlobalEnviron.time_paused:
		time += delta
		GlobalEnviron.time = time
		var value = (sin(sin_coefficient * (time - PI/2)) + 1.0) / 2.0
		#if self and gradient:
		self.color = gradient.gradient.sample(value)
