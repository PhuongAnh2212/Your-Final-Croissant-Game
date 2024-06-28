extends Node

#inventory slot
var inventory = []
#quest objecttive slot
var quest_objs = []

#Scene and nodes reference
var player_node: Node = null


#If interacting with an NPC or object
var interacting = false

#current state of the game
var states = {
	"active_quests": {},
	"finished_quest": [],
	"scene": "res://title screen/title_screen.tscn",
	"dialogue":"",
	"in_cutsence": false
}

#signals
signal inventory_update
signal interacting_inventory
signal state_change
signal quest_finished
signal quest_recieved
signal quest_obj_update
signal cutscene_changed


@onready var inventory_slot_scene = preload("res://scenes/inventory_slot.tscn")
@onready var quest_obj_scene = preload("res://script/quest_obj_slot.gd")

func _ready():
	inventory.resize(10)
	quest_objs.resize(8)
	inventory_update.connect(_on_inventory_change)
	state_change.connect(_on_state_change)

#All state change
func add_quest(quest):
	if quest != null and states["active_quests"] != quest:
		states["active_quests"] = quest
		for task in quest["quest_requirement"]:
			add_objective(task)
		state_change.emit("active_quests")
		quest_recieved.emit()
		return true
	return false

func finished_quest(quest):
	if quest == null or quest == "":
		return false
	if states["active_quests"] != null and states["active_quests"] == quest:
		states["finished_quest"].append(quest)
		states["active_quests"] = {
	"quest_name": "",
	"quest_steps": [],
	"quest_requirement": [],
	"quest_type": []
}
		state_change.emit("finished_quest")
		quest_finished.emit()
		return true
	return false

func update_state(state):
	if state.keys() in states:
		states = state
		state_change.emit("all")
		return true
	return false

func par_update_state(new_state, key):
	if key in states:
		if key != "scene" or new_state != "":
			states[key] = new_state
			state_change.emit(key)
			return true
	return false

func add_objective(objective):
	for i in range(quest_objs.size()):
		if quest_objs[i] == null:
			quest_objs[i] = objective
			quest_obj_update.emit()
			return true
	return false

func _on_inventory_change():
	if states["active_quests"] != null and "collect" in states["active_quests"]["quest_type"]:
		for i in range(quest_objs.size()):
			for j in range(inventory.size()):
				if (quest_objs[i] != null and inventory[j] != null):
					if (quest_objs[i]["item_name"] == inventory[j]["item_name"]) and (quest_objs[i]["item_type"] == inventory[j]["item_type"]) and (quest_objs[i]["quanity"] == inventory[j]["quanity"]):
						quest_objs[i]["clear"] = true
						quest_obj_update.emit()
						return true
	return false

func _on_state_change(key):
	if key == "scene" or key == "all":
		print(1)
		print(get_tree().current_scene.scene_file_path)
		if (get_tree().current_scene.scene_file_path != states["scene"]):
			get_tree().change_scene_to_file(states["scene"])
	

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
