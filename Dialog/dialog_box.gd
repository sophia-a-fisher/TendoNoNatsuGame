extends Control

@export var typing_speed: float = 0.05  # Speed of the typing effect (in seconds)
var fullText : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Position the dialog box at the bottom of the screen
	scale = Vector2(GlobalEnviron.camera_zoom, GlobalEnviron.camera_zoom)
	var screen_size = get_viewport().get_visible_rect().size
	position = Vector2((screen_size.x - size.x) / 2,  # Center horizontally
	screen_size.y - $"Background Art".texture.get_height() - 100    # 50 pixels from the bottom
	)
	
# Function to update the label with a typewriter effect
func typewriter_effect(dialog_text: String) -> void:
	$Dialog.text = ""  # Clear the label text at the beginning
	for char in dialog_text:
		if not DialogManager.typing:
			break  # Stop typing if the flag is false
		$Dialog.text += char  # Add one character at a time
		# Awaiting the timer here does not need 'async'
		await get_tree().create_timer(typing_speed).timeout # Wait for the specified duration
	DialogManager.typing = false
		
func set_dialog_text() -> void:
	$Dialog.text = fullText
	
func updateDisplay(characterName, dialogText, spritePath: String) -> void:
	DialogManager.typing = true
	fullText = dialogText
	$"Character Name".text = characterName
	# Load the sprite texture
	var texture = load(spritePath)  
	$"Character Head".texture = texture
	
	await typewriter_effect(dialogText)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
