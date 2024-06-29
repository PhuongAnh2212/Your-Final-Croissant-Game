extends Control
@onready var click = $click

#props
@export var item_type = ""
@export var item_name = ""
@export var item_text: Texture
@export var item_effect = ""




@onready var path = "res://scenes/ThanhMaiBakery/TMBakery.tscn"
@onready var dialogue = "res://dialogue/scene1.dtl"
@onready var quest = {
	"quest_name": "Give Anh Long cake",
	"current_step": 0,
	"quest_steps": ["Pick up 2 cakes", "Talk to Anh Long"],
	"quest_requirement": [{
		"quanity": 2,
		"item_type": item_type,
		"item_name": item_name,
		"item_text": item_text,
		"item_effect": item_effect,
		"clear": false
	}],
	"quest_type": ["collect", "talk"],
}


func _on_start_game_pressed():
	var states = {
	"active_quests": quest,
	"finished_quest": [],
	"scene": path,
	"dialogue":dialogue,
	"in_cutsence": true
}
	Global.update_state(states)

	#get_tree().change_scene_to_file("res://scenes/world.tscn") # Replace with function body.


func _on_quit_pressed():
	get_tree().quit() # Replace with function body.
