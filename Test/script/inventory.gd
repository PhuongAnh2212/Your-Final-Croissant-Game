extends Control

@onready var grid = $GridContainer

# Called when the node 
func _ready():
	Global.inventory_update.connect(_on_inventory_update)
	_on_inventory_update()

#update UI
func _on_inventory_update():
	clear_grid_container()
	#add slot
	for item in Global.inventory:
		var slot = Global.inventory_slot_scene.instantiate()
		grid.add_child(slot)
		if item != null:
			slot.set_item(item)
		else:
			slot.set_empty()

func clear_grid_container():
	while  grid.get_child_count() > 0:
		var child = grid.get_child(0)
		grid.remove_child(child)
		child.queue_free()
