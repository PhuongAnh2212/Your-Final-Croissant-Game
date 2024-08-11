extends Control
@onready var click = $click

@onready var path = "res://scenes/ThanhMaiBakery/TMBakery.tscn"
@onready var dialogue = "res://dialogue/scene1.dtl"
@onready var quest = Quests.get_current_quest()


func _on_start_game_pressed():
	var states = {
	"active_quests": quest,
	"finished_quest": Global.states["finished_quest"],
	"scene": path,
	"dialogue":dialogue,
	"in_cutscene": true
}
	Global.update_state(states)

	#get_tree().change_scene_to_file("res://scenes/world.tscn") # Replace with function body.


func _on_quit_pressed():
	get_tree().quit() # Replace with function body.
