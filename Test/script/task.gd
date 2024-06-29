extends Control


@onready var grid  = $GridContainer
@onready var quest_name =  $ColorRect/MarginContainer/Quest_name
@onready var quest_obj = $ColorRect/MarginContainer/Quest_obj



# Called when the node enters the scene tree for the first time.
func _ready():
	Global.quest_obj_update.connect(_on_objective_update)
	Global.objective_cleared.connect(_on_obj_cleared)
	Global.quest_finished.connect(_on_quest_update)
	Global.quest_recieved.connect(_on_quest_update)
	
	_on_quest_update()
	_on_objective_update()


#update UI
func _on_quest_update():
	quest_name.text = Global.states["active_quests"]["quest_name"]
	quest_obj.text = Global.states["active_quests"]["quest_steps"][Global.states["active_quests"]["current_step"]]
	
func _on_obj_cleared():
	quest_obj.text = Global.states["active_quests"]["quest_steps"][Global.states["active_quests"]["current_step"]]

func _on_objective_update():
	clear_grid_container()
	#add slot
	for item in Global.quest_objs:
		var slot = Global.quest_obj_scene.instantiate()
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
