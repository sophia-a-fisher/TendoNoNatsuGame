extends Node

var dialog_active = false
var dialog_box_instance = null
var player = null
var master_key : String
var typing : bool = false

# Dictionaries to store parsed CSV data
# Key is the key, item is the entire row including key
var dialogs = {}
var character_names = {}
var master_tree = {}
var LANG = "English"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_csv_data()
	
func _set_player(_player) -> void:
	player = _player;
	
# Start a dialog based on a master key
func start_dialog(_master_key: String):
	player.input_enabled = false
	player.velocity = Vector2(0,0)
	player.pick_new_state(player.velocity)
	master_key = _master_key
	dialog_active = true
	GlobalEnviron.time_paused = true
	show_dialog(master_key)
	
	var characterKey = master_tree[master_key]["Speaker"]
	var characterName = character_names[characterKey][LANG]
	var dialogKey = master_tree[master_key]["Dialog"]
	var dialogText = dialogs[dialogKey][LANG]
	var spritePath = master_tree[master_key]["Sprite"]

	dialog_box_instance.updateDisplay(characterName, dialogText, spritePath)

# Clean up after dialog ends
func end_dialog():
	if dialog_box_instance:
		dialog_box_instance.queue_free()
	player.input_enabled = true
	GlobalEnviron.time_paused = false
	dialog_active = false
	player.unpause_npc()
	
# Function to retrieve a random generic key for a character
func get_generic_key(character_name: String) -> String:
	# Define the prefix for generic dialogs
	var prefix = "GEN_" + character_name

	# Filter keys in master_tree that start with the specified prefix
	var matching_keys = []
	for key in master_tree.keys():
		if key.begins_with(prefix):
			matching_keys.append(key)

	# Check if there are any matching keys
	if matching_keys.size() == 0:
		print("No generic dialog found for character:", character_name)
		return "NA"  # or handle the case of no match as needed

	# Return a random key from the matching key
	return matching_keys[randi() % matching_keys.size()]
	
# Show dialog UI
func show_dialog(master_key: String):
	# Instantiate dialog box, populate it with data from master tree
	var dialog_box_scene = preload("res://Dialog/DialogBox.tscn")
	dialog_box_instance = dialog_box_scene.instantiate()

	# Add the dialog box to the CanvasLayer (which is in screen space)
	var hud_layer = get_tree().root.get_node("VillageLevel/HUD")  # Adjust path to your CanvasLayer node
	hud_layer.add_child(dialog_box_instance)

# Handle input events for advancing dialog or interacting with NPC
func _input(event):
	if event.is_action_pressed("ui_talk"):
		if not dialog_active:
			player.check_for_npc_interaction()
		else:
			if typing:
				typing = false
				dialog_box_instance.set_dialog_text()
			else:
				advance_dialog()
	#elif dialog_active and event.is_action_pressed("ui_accept"):
		
		
# Advance dialog
func advance_dialog():
	# Advance to the next key in the sequence
	var dialog_info = master_tree[master_key]
		# Return the "Next" key, which is at index 4 (0-based index)
	master_key = dialog_info["Next"]
	if master_key == "NA":
		end_dialog()
	else:
		var characterKey = master_tree[master_key]["Speaker"]
		var characterName = character_names[characterKey][LANG]
		var dialogKey = master_tree[master_key]["Dialog"]
		var dialogText = dialogs[dialogKey][LANG]
		var spritePath = master_tree[master_key]["Sprite"]
		dialog_box_instance.updateDisplay(characterName, dialogText, spritePath)
	pass
	
# Parse CSV data into dictionaries
func load_csv_data():
	 # Load the dialog CSV
	dialogs = load_csv_to_dict("res://Dialog/Dialog Translations - Sheet1.csv", ["Key", "English", "Japanese"])

	# Load the character names CSV
	character_names = load_csv_to_dict("res://Dialog/Charater Name Translations - Sheet1.csv", ["Key", "English", "Japanese"])

	# Load the master tree CSV
	master_tree = load_csv_to_dict("res://Dialog/Dialog Master Tree - Sheet1.csv", ["Key", "Speaker", "Dialog", "Sprite", "Next", "Choice"])

func load_csv_to_dict(path: String, headers: Array) -> Dictionary:
	var file = FileAccess.open(path, FileAccess.READ)
	var data_dict = {}

	if file:
		# Skip the header line
		file.get_line()

		# Parse each line in the file
		while not file.eof_reached():
			var line = file.get_line().strip_edges()
			var fields = parse_csv_line(line)

			# Ensure the number of fields matches the number of headers
			if fields.size() != headers.size():
				print("Warning: Number of fields does not match number of headers.")
				continue  # Skip this line or handle as needed

			# Use the first field (Key) as the unique identifier in our dictionary
			var key = fields[0].strip_edges().replace("\"", "")
			var entry = {}

			# Map headers to their respective fields
			for i in range(headers.size()):
				entry[headers[i]] = fields[i].strip_edges().replace("\"", "");  # Strip additional quotes if necessary

			# Store the entry dictionary in data_dict under the key
			data_dict[key] = entry

		file.close()
	return data_dict
	
# Helper function to parse a CSV line correctly
func parse_csv_line(line: String) -> Array:
	var fields = []
	var current_field = ""
	var inside_quotes = false
	var length = line.length()

	for i in range(length):
		var char = line[i]

		if char == "\"" and (i == 0 or line[i - 1] != "\\"):  # Check for unescaped quotes
			inside_quotes = !inside_quotes  # Toggle the inside_quotes state
		elif char == "," and !inside_quotes:
			fields.append(current_field.strip_edges())  # Add the field and reset current_field
			current_field = ""
		else:
			current_field += char  # Append the character to the current field

	# Add the last field if there's any data left
	if current_field != "":
		fields.append(current_field.strip_edges())

	return fields

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
