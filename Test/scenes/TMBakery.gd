extends Area2D

var entered = false

@onready var label_door = $LabelDoor

func _ready() -> void:
	label_door.global_position.y = 1647
	label_door.global_position.x = 637
	label_door.hide()  # Ensure the label is initially hidden

func _on_body_entered(body: CharacterBody2D) -> void:
	entered = true
	label_door.show()
	print("Body entered, label shown")  # Debug print
	print("Label position:", label_door.global_position)  # Debug print
	print("Label size:", label_door.get_minimum_size())  # Debug print

func _on_body_exited(body: CharacterBody2D) -> void:
	entered = false
	label_door.hide()
	print("Body exited, label hidden")  # Debug print

func _process(delta: float) -> void:
	if entered:
		if Input.is_action_just_pressed("opendoor"):
			print("Door opening...")  # Debug print
			get_tree().change_scene_to_file("res://scenes/ThanhMaiBakery/TMBakery.tscn")
