extends CharacterBody2D
const speed = 300

@onready var animations = $AnimationPlayer
@onready var Map = $"../UI/TextureRect/SubViewportContainer/SubViewport/MiniCam"

func handleInput():
	if Input.is_action_just_pressed("ui_accept"):
		DialogueManager.show_dialogue_balloon(load("res://dialogue/main.dialogue"), "start")
		return
	
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection*speed
	

func updateAnimation():
	if velocity.length() == 0:
		animations.play("Idle")
	else:
		var direction = "Front"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Back"

		animations.play("walk" + direction)
		
func _physics_process(_delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction: 
		velocity.x = direction * speed
		Map.updateMap()
	else: 
		velocity.x = move_toward(velocity.x, 0, speed)
	handleInput()
	move_and_slide()
	updateAnimation()
