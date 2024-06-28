extends CharacterBody2D
const speed = 300
@onready var paused = false

@onready var animations = $AnimationPlayer
@onready var inventory = $Inventory_UI
@onready var quest_menu = $Quest_menu_UI
@onready var phone_menu = $Phone_UI


func _ready():
	Global.set_player_ref(self)
	Global.interacting_inventory.connect(_on_pop_up_interaction)
	_on_pop_up_interaction()
	Dialogic.timeline_started.connect(_on_dialogue_start)
	Dialogic.timeline_ended.connect(_on_dialogue_ended)

func _input(event):
	if event.is_action_pressed("inventory"):
		if quest_menu.visible == true or phone_menu.visible== true:
			return
		inventory.visible = !inventory.visible
		paused = !paused
	elif event.is_action_pressed("quest"):
		if inventory.visible == true or phone_menu.visible== true:
			return
		quest_menu.visible = !quest_menu.visible
		paused = !paused
	elif event.is_action_pressed("phone"):
		if inventory.visible == true or quest_menu.visible== true:
			return
		phone_menu.visible = !phone_menu.visible
		paused = !paused
		

func _on_dialogue_start():
	if Dialogic.current_timeline != null:
		paused = true

func _on_dialogue_ended():
	if Dialogic.current_timeline == null:
		paused = false
	

func _on_pop_up_interaction():
	var layout = Dialogic.Styles.get_layout_node()
	if Global.interacting:
		inventory.visible = !inventory.visible
		if Dialogic.current_timeline != null:
			Dialogic.paused = true
			layout.hide()
		paused = true
	else:
		if Dialogic.current_timeline != null:
			Dialogic.paused = false
			layout.show()
		inventory.visible = false
		paused = false
	

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
