extends CharacterBody2D

@onready var animations = $AnimatedSprite2D
@export var animation_sprite: SpriteFrames
@export var speaker_name= ""
#props
@export var item_type = ""
@export var item_name = ""
@export var item_text: Texture
@export var item_effect = ""

var scene_path: String = "res://scenes/Inventory_Item.tscn" 
var player_in_range = false


func _ready():
	animations.sprite_frames = animation_sprite

func _process(delta):
	var item = {
	"quanity": 1,
	"item_type": item_type,
	"item_name": item_name,
	"item_text": item_text,
	"item_effect": item_effect,
	"scene_path": scene_path
	}
	if player_in_range and Input.is_action_just_pressed("add"):
		giveItem(item)
		
	if player_in_range and Input.is_action_just_pressed("talk"):
		if Dialogic.current_timeline == null:
			Dialogic.VAR.current_speaker = speaker_name
			Dialogic.start('testing')
		#Global.enter_interacting()
		


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false



func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true


func updateAnimation():
	animations.play("Idle")

func _physics_process(delta):
	updateAnimation()

func giveItem(item):
	if Global.player_node:
		Global.add_item(item)

