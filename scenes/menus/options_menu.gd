extends MenuBase

@onready var fullscreen_toggle = $Contents/VBoxContainer/HBoxContainer/FullScreen	

func _ready():
	var window = get_window()
	assert (fullscreen_toggle)
	fullscreen_toggle.button_pressed = window.mode & (Window.Mode.MODE_EXCLUSIVE_FULLSCREEN | Window.Mode.MODE_FULLSCREEN) != 0

func _on_full_screen_toggled(_toggled_on):
	var window = get_window()	
	window.mode = Window.Mode.MODE_EXCLUSIVE_FULLSCREEN if _toggled_on else Window.Mode.MODE_WINDOWED 
		
