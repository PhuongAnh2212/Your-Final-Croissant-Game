extends Node

var current_quest_index = 0

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
	"quest_requirement": [],
	"quest_type": ["talk"],
},
]

var item_dict ={
	
	
}
