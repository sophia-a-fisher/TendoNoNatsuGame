extends Node2D

func _input(event):
	if event.is_action_pressed("ui_cancel"):  # Check for the Escape key
		get_tree().quit()  # Close the game
		
func setup_HUD():
	if not HUD.is_queued_for_deletion():
		add_child(HUD)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_HUD()
	VillagerManager._create_patrol_point_positions()
	VillagerManager.spawn_villagers_in_village($Sorting/VillagerContainer)
	var player_node = get_node("Sorting/MainPlayer")
	if player_node:
		PlayerManager.setup_player(player_node)
		
func _process(delta: float) -> void:
	VillagerManager.update_villager_despawn($Sorting/VillagerContainer)
	VillagerManager.update_villager_spawn($Sorting/VillagerContainer)
