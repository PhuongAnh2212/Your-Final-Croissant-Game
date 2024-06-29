extends Control

@onready var load = $"."
@export var next_scene= ""
# Called when the node enters the scene tree for the first time.
func _ready():
	load.top_level = true
	pass # Replace with function body.

func set_path(path):
	next_scene = path
	ResourceLoader.load_threaded_request(next_scene)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if next_scene == "":
		return

	var progress = []
	ResourceLoader.load_threaded_get_status(next_scene, progress)
	if progress[0] == 1:
		var packed_scene = ResourceLoader.load_threaded_get(next_scene)
		get_tree().change_scene_to_packed(packed_scene)
		self.queue_free()
	
	pass
