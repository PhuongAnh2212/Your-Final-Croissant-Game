@tool
extends Node2D

#props
@export var item_type = ""
@export var item_name = ""
@export var item_text: Texture
@export var item_effect = ""

var scene_path: String = "res://scenes/Inventory_Item.tscn" 

var player_in_range = false


# Node ref
@onready var icon_sprite = $"2DSprite"

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		icon_sprite.texture = item_text
	
	if player_in_range and Input.is_action_just_pressed("add"):
		pickup()

func pickup():
	var item = {
		"quanity": 1,
		"item_type": item_type,
		"item_name": item_name,
		"item_text": item_text,
		"item_effect": item_effect,
		"scene_path": scene_path
	}
	if Global.player_node:
		Global.add_item(item)
		self.queue_free()


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false



func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true
