extends CharacterBody2D
const speed = 300
@onready var paused = false

@onready var animations = $AnimationPlayer
@onready var inventory = $Inventory_UI



func _ready():
	Global.set_player_ref(self)
	Global.interacting_inventory.connect(_on_pop_up_interaction)
	_on_pop_up_interaction()
	Dialogic.timeline_started.connect(_on_dialogue_start)
	Dialogic.timeline_ended.connect(_on_dialogue_ended)

func _input(event):
	if event.is_action_pressed("inventory"):
		inventory.visible = !inventory.visible
		get_tree().paused = !get_tree().paused

func _on_dialogue_start():
	if Dialogic.current_timeline != null:
		paused = true

func _on_dialogue_ended():
	if Dialogic.current_timeline == null:
		paused = false
	

func _on_pop_up_interaction():
	if Global.interacting:
		inventory.visible = !inventory.visible
		get_tree().paused = !get_tree().paused
	else:
		inventory.visible = false
		get_tree().paused = false
	
	
func handleInput():
#	if Input.is_action_just_pressed("ui_accept"):
#		DialogueManager.show_dialogue_balloon(load("res://dialogue/main.dialogue"), "start")
#		return
	
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
	if get_tree().paused or paused:
		return
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction: 
		velocity.x = direction * speed

	else: 
		velocity.x = move_toward(velocity.x, 0, speed)
	handleInput()
	move_and_slide()
	updateAnimation()
