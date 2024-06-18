extends Area2D

var entered = false
@onready var label_door_out = $LabelDoorOut
@export var label_text: String = "[E] Go out"
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	label_door_out.text = label_text
	label_door_out.global_position.y = 737
	label_door_out.global_position.x = 230
	label_door_out.hide()  # Ensure the label is initially hidden
	
func _on_body_entered(body: CharacterBody2D):
	entered = true
	label_door_out.show()
	print("Body entered, label shown")  # Debug print

func _on_body_exited(body):
	entered = false
	label_door_out.hide()
	print("Body exit, label off")  # Debug print
	
func _process(delta):  
	if entered == true:
		if Input.is_action_just_pressed("opendoor"):
			get_tree().change_scene_to_file("res://scenes/world.tscn")
