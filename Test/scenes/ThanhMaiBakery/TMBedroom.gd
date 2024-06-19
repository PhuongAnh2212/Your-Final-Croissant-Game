extends Area2D

var entered = false
@onready var label_bedroom = $LabelBedroom
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	label_bedroom.global_position.y = 209
	label_bedroom.global_position.x = 492
	label_bedroom.hide()  # Ensure the label is initially hidden
	
func _on_body_entered(body: CharacterBody2D):
	entered = true
	label_bedroom.show()
	print("Body entered, label shown")  # Debug print

func _on_body_exited(body: CharacterBody2D):
	entered = false
	label_bedroom.hide()
	print("Body exit, label off")  # Debug print
	
func _process(delta):  
	if entered == true:
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene_to_file("res://scenes/ThanhMaiBakery/TMBedroom.tscn")
