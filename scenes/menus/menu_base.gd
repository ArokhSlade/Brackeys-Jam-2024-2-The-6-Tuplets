class_name MenuBase
extends ReferenceRect

signal menu_closed

@export var parent_menu : MenuBase
@onready var menu_contents = $Contents

# NOTE (arokh slade): better set visibility in scene window, otherwise it's hard to test (f6)
#func _ready():
	#visible = false

func open_menu():
	visible = true
	if (parent_menu) : 
		parent_menu.menu_contents.visible = false
		
		
func close_menu():
	visible = false
	if (parent_menu) : 
		parent_menu.menu_contents.visible = true
	menu_closed.emit()
