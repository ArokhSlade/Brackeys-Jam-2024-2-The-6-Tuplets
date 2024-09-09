extends MenuBase

func reset_menu():
	$OptionsMenu.close_menu()
	#$OptionsMenu.hide() #TODO(ArokhSlade): figure out why this doesn't work

func open_pause_menu():
	get_tree().paused = true
	reset_menu()
	show()
	
func close_pause_menu():
	get_tree().paused = false
	hide()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if not visible: 
			open_pause_menu()
		else: 
			close_pause_menu()
