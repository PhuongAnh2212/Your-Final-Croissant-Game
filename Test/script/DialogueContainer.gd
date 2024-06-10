extends Control

@onready var avatar = $Dialogue/HFlowContainer/TextureRect2/PanelContainer/Icon
@onready var speaker = $Dialogue/HFlowContainer/TextureRect/MarginContainer/Name
@onready var dialogue = $Dialogue/TextureRect2/MarginContainer/Dialogue
@onready var state={}


@export var avatar_sprite : Texture
@export var speaker_name = " "
@export var dialouge_text = " "



var player_in_range = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#($Dialogue/EzDialogue as EzDialogue).start_dialogue(dialogue_json, state)
	pass # Replace with function body.

func clear_text():
	avatar.texture = null
	speaker.text = " "
	dialogue.text = " "

func add_text(text: String):
	dialogue.text = text
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func _on_ez_dialogue_dialogue_generated(response):
	add_text(response.text)

	pass # Replace with function body.
