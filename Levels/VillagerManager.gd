extends Node

# Enum for possible villager scenes
enum SceneType {
	HOME,
	VILLAGE
}

# Array of data stored for each villager
var villagers = [
	{
		"name": "Mable",
		"home_scene": "res://Asset Scenes/House Interiors/house1_interior.tscn",
		"villager_scene": "res://Characters/Villager1.tscn",
		"village_position": Vector2(-9, -107),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_time_array": [],
		"next_point_array": [],
		"next_point_positions": [], 
	},
	# Add more villagers as needed
]

func update_villager_state(name, new_scene):
	for villager in villagers:
		if villager.name == name:
			villager.current_scene = new_scene
			villager.spawned = false  # Reset spawned status
			break

func spawn_villager(name, parent_node):
	for villager in villagers:
		if villager.name == name and not villager.spawned:
			var villager_scene = load(villager.villager_scene)
			var villager_instance = villager_scene.instantiate()
			villager_instance.position = villager.village_position if villager.current_scene == SceneType.VILLAGE else villager.house_position
			parent_node.add_child(villager_instance)
			villager.spawned = true
			break
			
func despawn_villager(name):
	for villager in villagers:
		if villager.name == name and not villager.spawned:
			villager.spawned = false
			break

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
