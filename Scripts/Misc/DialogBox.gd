# Represents the dialog box GUI

extends Control

var full_text : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale_dialog_box()
	position_dialog_box()
	
func scale_dialog_box() -> void:
	scale = Vector2(GameManager.camera_zoom, GameManager.camera_zoom)
	
# Positioning horizontally centered, and 50 pixels from bottom
func position_dialog_box() -> void:
	var screen_size = get_viewport().get_visible_rect().size
	position = Vector2((screen_size.x - size.x) / 2, 
	screen_size.y - $"Background Art".texture.get_height() - 100)
	
# Updates the label with a typewriter effect
func typewriter_effect(dialog_text: String) -> void:
	$Dialog.text = ""  # Clear the label text at the beginning
	for char in dialog_text:
		# Checking the user has skipped through typewriting at any point
		if not DialogManager.typing:
			break  # Stop typing
		$Dialog.text += char  # Add one character at a time
		# Wait for the specified duration between each typed letter
		await get_tree().create_timer(DialogManager.typing_speed).timeout 
	DialogManager.typing = false
		
# Updates the label to show full dialog
func set_dialog_text() -> void:
	$Dialog.text = full_text
	
# Initiates the dialog box update with typewriter effect
func update_display(character_name, dialog_text, sprite_path: String) -> void:
	DialogManager.typing = true
	full_text = dialog_text
	
	$"Character Name".text = character_name
	var texture = load(sprite_path)  
	$"Character Head".texture = texture
	await typewriter_effect(dialog_text)
