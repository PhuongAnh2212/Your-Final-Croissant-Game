extends Node

signal quest_change

var current_quest_index = 0

var empty_quest = {
	"quest_name": "Empty Quest",
	"current_step": 0,
	"quest_steps": ["Nothing to do"],
	"quest_requirement": [""],
	"quest_type": [""]
}

var quest_progress= [
{
	"quest_name": "Give Anh Long cake",
	"current_step": 0,
	"quest_steps": ["Pick up 2 cakes", "Talk to Anh Long"],
	"quest_requirement": [{
		"quanity": 2,
		"item_type": "key",
		"item_name": "Cake",
		"item_text": load("res://arts/Items/Bakery_goods (1).png"),
		"item_effect": "",
		"clear": false
	}],
	"quest_type": ["collect", "talk"],
},
{
	"quest_name": "Ask Angelo abt stuff",
	"current_step": 0,
	"quest_steps": ["Talk to Angelo"],
	"quest_requirement": [""],
	"quest_type": ["talk"],
},
]

var item_dict ={
	
	
}

func get_current_quest():
	if current_quest_index >= quest_progress.size():
		return empty_quest
	return quest_progress[current_quest_index]

func next_quest():
	if current_quest_index < quest_progress.size():
		current_quest_index += 1
		quest_change.emit()
		return true
	return false

func jump_to_quest(index):
	if index < quest_progress.size():
		current_quest_index = index
		quest_change.emit()
		return true
	return false


func get_item(item_name):
	if item_name in item_dict:
		return item_dict[item_name]
	
