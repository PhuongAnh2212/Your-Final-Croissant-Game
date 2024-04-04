extends Node



#inventory slot
var inventory = []

#signals
signal inventory_update

#Scene and nodes reference
var player_node: Node = null
@onready var inventory_slot_scene = preload("res://scenes/inventory_slot.tscn")


func _ready():
	inventory.resize(12)

func add_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["item_type"] == item["item_type"] and inventory[i]["item_effect"] == item["item_effect"]:
			inventory[i]["quanity"] += item["quanity"]
			inventory_update.emit()
			return true
		elif inventory == null:
			inventory[i] = item
			inventory_update.emit()
			return true
	return false
	
func remove_item():
	inventory_update.emit()

func increase_inventory_size():
	inventory_update.emit()

func set_player_ref(player):
	player_node=player
