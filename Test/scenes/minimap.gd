extends SubViewport

@onready var camera = $MiniCam

func _physics_process(_delta):
	if camera != null:
		camera.position = owner.find_child("$../../../Player").position
	else:
		print("Error: Camera not found or not ready.")
