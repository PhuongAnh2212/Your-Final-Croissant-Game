extends Camera2D

@onready var Player = $"../../../../../Player"

func updateMap():
	updatePosition()

func updatePosition():
	self.position = Player.position
	$"../Pointer".position = Player.position
	#print(Player.position)
