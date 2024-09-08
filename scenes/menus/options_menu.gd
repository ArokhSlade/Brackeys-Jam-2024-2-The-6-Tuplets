extends CanvasLayer

func _on_full_screen_toggled(_toggled_on):
	var window = get_window()
	if window.mode & (Window.Mode.MODE_EXCLUSIVE_FULLSCREEN | Window.Mode.MODE_FULLSCREEN):
		window.mode = Window.Mode.MODE_WINDOWED
	else:
		window.mode = Window.Mode.MODE_EXCLUSIVE_FULLSCREEN
