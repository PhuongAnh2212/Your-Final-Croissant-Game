extends Node

#inventory slot
var inventory = []

#Scene and nodes reference
var player_node: Node = null


#If interacting with an NPC or object
var interacting = false

#current state of the game
var states = {
	"speaker": "",
	"quests": [],
	"scene": "",
	"dialogue":"",
	"in_cutsence": false
}

#signals
signal inventory_update
signal interacting_inventory
signal state_change
signal quest_finished
signal quest_recieved

@onready var inventory_slot_scene = preload("res://scenes/inventory_slot.tscn")


func _ready():
	inventory.resize(12)

#All state change
func add_quest(quest):
	if quest != null and quest not in states["quests"]:
		states["quests"].append(quest)
		state_change.emit()
		quest_recieved.emit()
		return true
	return false

func remove_quest(quest):
	if quest == null or quest == "":
		return false
	for i in range(states["quests"].size()):
		if states["quests"][i] != null and states["quests"][i] == quest:
			states["quests"].remove_at(i)
			state_change.emit()
			quest_finished.emit()
			return true
	return false

func update_state(old_state, new_state):
	state_change.emit()

#Add remove items
func add_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["item_type"] == item["item_type"] and inventory[i]["item_name"] == item["item_name"]:
			inventory[i]["quanity"] += item["quanity"]
			inventory_update.emit()
			return true
		elif inventory[i] == null:
			inventory[i] = item
			inventory_update.emit()
			return true
	return false
	
func remove_item(item_type, item_name):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["item_type"] == item_type and inventory[i]["item_name"] == item_name:
			inventory[i]["quanity"] -= 1
			if inventory[i]["quanity"] <= 0:
				inventory[i]= null
			inventory_update.emit()
			return true
	return false
	

func increase_inventory_size():
	inventory_update.emit()

#Set player ref
func set_player_ref(player):
	print("A")
	player_node=player
	

#Dropping items
func adjust_drop_pos(position):
	var radius = 100
	var nearby_item = get_tree().get_nodes_in_group("Item")
	for item in nearby_item:
		if item.global_position.distance_to(position) < radius:
			var random_offset = Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
			position += random_offset
			break
	return position

func drop_item(item_data, drop_position):
	var item_scene = load(item_data["scene_path"])
	var item_instance = item_scene.instantiate()
	item_instance.set_item_data(item_data)
	drop_position = adjust_drop_pos(drop_position)
	item_instance.global_position = drop_position
	get_tree().current_scene.add_child(item_instance)

#Going in an interaction with NPC
func enter_interacting():
	interacting = true
	interacting_inventory.emit()
	return
	
func exit_interacting():
	interacting = false
	interacting_inventory.emit()
	return
