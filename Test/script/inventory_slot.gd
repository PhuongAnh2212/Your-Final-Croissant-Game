extends Control
@onready var icon = $TextureRect/Item
@onready var detail_panel = $detail
@onready var item_name = $detail/Name
@onready var item_type = $detail/Type
@onready var usage_panel = $Interact

var item = null


func _on_item_button_pressed():
	if item != null:
		usage_panel.visible = !usage_panel.visible


func _on_item_button_mouse_exited():
	if item != null:
		detail_panel.visible = false


func _on_item_button_mouse_entered():
	if item != null:
		usage_panel.visible = false
		detail_panel.visible = true

func set_empty():
	icon.texture =  null

func set_item(new_item):
	item = new_item
	icon.texture = new_item["item_text"]
	item_name.text = str(item["item_name"])
	item_type.text = str(item["item_type"])

