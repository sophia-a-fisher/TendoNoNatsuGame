extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.visible = false
	animation_player.animation_finished.connect(on_animation_finished)
	
	
func on_animation_finished(anim_name):
		if anim_name == "fade_to_black":
			on_transition_finished.emit()
			animation_player.play("fade_to_scene")
		elif anim_name == "fade_to_scene":
			color_rect.visible = false
			
func transition():
	color_rect.visible = true;
	animation_player.play("fade_to_black")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
