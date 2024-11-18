extends Node

# Path to the data table scene
@export var villager_data_table_path: String = "res://Data Assets/VillagerDataTable.tscn"
var created_patrol_points: bool = false
var speed : float = 40

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
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Cecily",
		"home_scene": "res://Asset Scenes/House Interiors/house2_interior.tscn",
		"villager_scene": "res://Characters/Villager2.tscn",
		"village_position": Vector2(-616, -148),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Azuki",
		"home_scene": "res://Asset Scenes/House Interiors/house3_interior.tscn",
		"villager_scene": "res://Characters/Villager3.tscn",
		"village_position": Vector2(-1007, -243),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Hideji",
		"home_scene": "res://Asset Scenes/House Interiors/house4_interior.tscn",
		"villager_scene": "res://Characters/Villager4.tscn",
		"village_position": Vector2(-1042, 311),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Akio",
		"home_scene": "res://Asset Scenes/House Interiors/house5_interior.tscn",
		"villager_scene": "res://Characters/Villager5.tscn",
		"village_position": Vector2(-1052, 662),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Harold",
		"home_scene": "res://Asset Scenes/House Interiors/house6_interior.tscn",
		"villager_scene": "res://Characters/Villager6.tscn",
		"village_position": Vector2(-660, 793),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Stella",
		"home_scene": "res://Asset Scenes/House Interiors/house7_interior.tscn",
		"villager_scene": "res://Characters/Villager7.tscn",
		"village_position": Vector2(-433, 943),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Rika",
		"home_scene": "res://Asset Scenes/House Interiors/house8_interior.tscn",
		"villager_scene": "res://Characters/Villager8.tscn",
		"village_position": Vector2(-264, 1014),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Ethel",
		"home_scene": "res://Asset Scenes/House Interiors/house9_interior.tscn",
		"villager_scene": "res://Characters/Villager9.tscn",
		"village_position": Vector2(-34, 1111),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Orton",
		"home_scene": "res://Asset Scenes/House Interiors/house10_interior.tscn",
		"villager_scene": "res://Characters/Villager10.tscn",
		"village_position": Vector2(340, -92),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Frank",
		"home_scene": "res://Asset Scenes/House Interiors/house11_interior.tscn",
		"villager_scene": "res://Characters/Villager11.tscn",
		"village_position": Vector2(249, 106),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Othello",
		"home_scene": "res://Asset Scenes/House Interiors/house12_interior.tscn",
		"villager_scene": "res://Characters/Villager12.tscn",
		"village_position": Vector2(409, 378),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Samira",
		"home_scene": "res://Asset Scenes/House Interiors/house13_interior.tscn",
		"villager_scene": "res://Characters/Villager13.tscn",
		"village_position": Vector2(-620, 148),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Miranda",
		"home_scene": "res://Asset Scenes/House Interiors/house14_interior.tscn",
		"villager_scene": "res://Characters/Villager14.tscn",
		"village_position": Vector2(-529, 409),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Tomiko",
		"home_scene": "res://Asset Scenes/House Interiors/house15_interior.tscn",
		"villager_scene": "res://Characters/Villager15.tscn",
		"village_position": Vector2(-5, 393),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Domingo",
		"home_scene": "res://Asset Scenes/House Interiors/house16_interior.tscn",
		"villager_scene": "res://Characters/Villager16.tscn",
		"village_position": Vector2(-544, 543),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	{
		"name": "Takumi",
		"home_scene": "res://Asset Scenes/House Interiors/house17_interior.tscn",
		"villager_scene": "res://Characters/Villager17.tscn",
		"village_position": Vector2(41, 644),
		"house_position": Vector2(-143, 61),
		"current_scene": SceneType.HOME, 
		"spawned": false,
		"next_point_array": [],
		"next_time_array": [],
		"next_point_positions": [],
		"next_point_idx": 0,
 		"next_time_idx": 0,
 		"path_idx": 0
	},
	# Add more villagers as needed
]

func _ready():
	load_villager_data()
	
func update_villager_spawn(village_scene):
	for villager in villagers:
		# Check if the villager is scheduled to be in the village at the current time
		if villager["next_time_idx"] < villager["next_time_array"].size():
			var spawn_time = villager["next_time_array"][villager["next_time_idx"]] * 600  # Convert to in-game time units (e.g., minutes to seconds)

			if GameManager.time >= spawn_time:
				# Spawn the villager in the village
				if not villager["spawned"]:  # If not already spawned
					villager["current_scene"] = SceneType.VILLAGE
					spawn_villagers_in_village(village_scene)

				# Update to next time and point
				villager["next_time_idx"] += 1
				villager["next_point_idx"] += 1
				
func update_villager_despawn(village_scene):
	for child in village_scene.get_children():
		if child.is_in_group("Villager") and (child.next_time_idx >= child.next_time_array.size()):
			for villager in villagers:
				if child.dialog_prefix == villager["name"]:
					villager["current_scene"] = SceneType.HOME
					child.queue_free()
				
func update_villager_position(villager_data):
	var time_idx = 0
	var current_position = villager_data["village_position"]
	for time in villager_data["next_time_array"]:
		if (time * 600) > GameManager.time:
			break
		else:
			time_idx += 1
			
	if time_idx >= villager_data["next_time_array"].size():
		villager_data["next_point_idx"] = time_idx - 1
		villager_data["next_time_idx"] = time_idx - 1
		var prev_target_path = villager_data["next_point_positions"][time_idx - 1]
		villager_data["village_position"] = prev_target_path[prev_target_path.size() - 1]
		villager_data["current_scene"] = SceneType.HOME
		return
			
	villager_data["next_point_idx"] = time_idx
	villager_data["next_time_idx"] = time_idx
	var target_path = villager_data["next_point_positions"][time_idx]
	var time_delta = GameManager.time - (villager_data["next_time_array"][time_idx - 1]*600)
	if time_idx > 0:
		var prev_target_path = villager_data["next_point_positions"][time_idx - 1]
		current_position = prev_target_path[prev_target_path.size() - 1] 

	var path_idx = 0
	for target_position in target_path:
		# Move the villager towards the target position based on the time delta
		var move_direction = target_position - current_position
		var move_distance = move_direction.length()
		var move_amount = speed * time_delta
		var time_took = move_distance / speed

		if move_amount >= move_distance:
			villager_data["village_position"] = target_position  # reached the target
			current_position = target_position
			time_delta -= time_took
			path_idx += 1
		else:
			villager_data["village_position"] += move_direction.normalized() * move_amount
			break
	if path_idx == 0:
		villager_data["next_point_idx"] = time_idx - 1
		villager_data["next_time_idx"] = time_idx - 1
	
	villager_data["path_idx"] = path_idx

# Load data from the villager data table scene
func load_villager_data():
	var data_table_scene = load(villager_data_table_path)
	var data_table_instance = data_table_scene.instantiate()
	
	var index = 0
	for child in data_table_instance.get_children():
		if villagers.size() > index:
			var villager = villagers[index]
			villager["next_point_array"] = child.get("next_point_array")
			villager["next_time_array"] = child.get("next_time_array")	
			index += 1
			
func _create_patrol_point_positions() -> void:
	if !created_patrol_points:
		for villager in villagers:
			villager["next_point_positions"] = [[]]
			var first_elem : bool = true
			for path_array in villager["next_point_array"]:
				var position_array : Array = []
				if first_elem:
					position_array = villager["next_point_positions"][0]
					
				for path_group_id in path_array:
		#			For now we will ignore if we are in the house interior
					if get_tree().get_nodes_in_group(path_group_id):
						var node = get_tree().get_nodes_in_group(path_group_id)[0]
						position_array.append(node.position)
				if first_elem:
					first_elem = false
				else:
					villager["next_point_positions"].append(position_array)
		created_patrol_points = true
		
# Updating all villager states to not spawned
func reset_villager_spawned():
	for villager in villagers:
			villager["spawned"] = false
			
func update_villager_state(name, new_scene):
	for villager in villagers:
		if villager.name == name:
			villager.current_scene = new_scene
			villager.spawned = false  # Reset spawned status
			break
			
func spawn_villagers_in_village(new_scene):
	for villager in villagers:
		if villager["current_scene"] == SceneType.VILLAGE and not villager["spawned"]:
			update_villager_position(villager)
			spawn_villager(villager["name"], new_scene)

func spawn_villager(name, parent_node):
	for villager in villagers:
		if villager.name == name and not villager.spawned:
			var villager_scene = load(villager.villager_scene)
			var villager_instance = villager_scene.instantiate()
			villager_instance.position = villager.village_position if villager.current_scene == SceneType.VILLAGE else villager.house_position
			villager_instance.next_time_idx = villager["next_time_idx"]
			villager_instance.next_point_idx = villager["next_point_idx"]
			villager_instance.path_idx = villager["path_idx"]
			if villager["current_scene"] == SceneType.VILLAGE:
				villager_instance.move_finished = false
			parent_node.add_child(villager_instance)
			villager.spawned = true
			break

func spawn_villagers_in_house(new_scene):
	for villager in villagers:
		if villager["current_scene"] == SceneType.HOME and not villager["spawned"] and GameManager.current_scene == villager["home_scene"]:
			spawn_villager(villager["name"], new_scene)
