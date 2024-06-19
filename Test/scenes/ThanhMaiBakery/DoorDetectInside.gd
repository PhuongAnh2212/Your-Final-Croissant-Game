extends Area2D

var entered = false
@onready var label_out = $LabelDoorOut
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	label_out.global_position.y = 747
	label_out.global_position.x = 232
	label_out.hide()  # Ensure the label is initially hidden
	
func _on_body_entered(body: CharacterBody2D):
	entered = true
	label_out.show()
	print("Body entered, label shown")  # Debug print

func _on_body_exited(body: CharacterBody2D):
	entered = false
	label_out.hide()
	print("Body exit, label off")  # Debug print
	
func _process(delta):  
	if entered == true:
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene_to_file("res://scenes/world.tscn")
