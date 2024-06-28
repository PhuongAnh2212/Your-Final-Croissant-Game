extends Control
@onready var click = $click

#props
@export var item_type = ""
@export var item_name = ""
@export var item_text: Texture
@export var item_effect = ""


var states = {
	"active_quests": {},
	"finished_quest": [],
	"scene": "",
	"dialogue":"",
	"in_cutsence": false
}

@onready var path = "res://scenes/world.tscn"
@onready var dialogue = "res://dialogue/testing.dtl"
@onready var quest = {
	"quest_name": "Give Anh Long a cake",
	"quest_steps": ["Pick up a cake", "Give Anh Long the cake"],
	"quest_requirement": [{
		"quanity": 2,
		"item_type": item_type,
		"item_name": item_name,
		"item_text": item_text,
		"item_effect": item_effect,
		"clear": false
	}],
	"quest_type": ["collect", "interact"]
}


func _on_start_game_pressed():
	Global.par_update_state(dialogue, "dialogue")
	Global.add_quest(quest)
	Global.par_update_state(path, "scene")
	#get_tree().change_scene_to_file("res://scenes/world.tscn") # Replace with function body.


func _on_quit_pressed():
	get_tree().quit() # Replace with function body.
