extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	AudioController.background_player.stream = AudioController.menu_music
	AudioController.background_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
