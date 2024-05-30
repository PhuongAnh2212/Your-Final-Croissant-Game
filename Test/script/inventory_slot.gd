extends Control
@onready var icon = $TextureRect/Item
@onready var detail_panel = $detail
@onready var item_name = $detail/Name
@onready var item_type = $detail/Type
@onready var usage_panel = $Interact
@onready var item_quanity = $TextureRect/Quanity
@onready var interactive_panel = $Interact2

var item = null



func _on_item_button_pressed():
	if item != null and !Global.interacting:
		usage_panel.visible = !usage_panel.visible
		interactive_panel.visible = false
	if item != null and Global.interacting:
		interactive_panel.visible = !interactive_panel.visible


func _on_item_button_mouse_exited():
	if item != null:
		detail_panel.visible = false


func _on_item_button_mouse_entered():
	if item != null:
		detail_panel.visible = true

func set_empty():
	icon.texture =  null

func set_item(new_item):
	item = new_item
	icon.texture = new_item["item_text"]
	item_name.text = str(item["item_name"])
	item_type.text = str(item["item_type"])
	item_quanity.text = str(item["quanity"])



func _on_drop_pressed():
	if item != null:
		var drop_position = Global.player_node.global_position
		var drop_offset = Vector2(0, 50)
		drop_offset = drop_offset.rotated(Global.player_node.rotation)
		Global.drop_item(item, drop_position + drop_offset)
		Global.remove_item(item["item_type"], item["item_name"])
		usage_panel.visible = false


func _on_give_pressed():
	if item!=null:
		Global.remove_item(item["item_type"], item["item_name"])
		interactive_panel = false
		Global.exit_interacting()
