extends CharacterBody2D

@export var speed: int = 300
@onready var animations = $AnimationPlayer
@onready var inventory = $Inventory_UI



func _ready():
	Global.set_player_ref(self)

func _input(event):
	if event.is_action_pressed("inventory"):
		inventory.visible = !inventory.visible
		get_tree().paused = !get_tree().paused

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
func _physics_process(delta):
	if get_tree().paused:
		return
	handleInput()
	move_and_slide()
	updateAnimation()
