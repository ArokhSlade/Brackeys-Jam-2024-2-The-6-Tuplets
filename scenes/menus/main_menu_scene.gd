extends CanvasLayer

@onready var music_player = $AudioStreamPlayer 
# Called when the node enters the scene tree for the first time.
func _ready():	
	
	music_player.stream = AudioController.menu_music
	music_player.play()
	#AudioController.background_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_audio_stream_player_finished():
	music_player.play()
