extends Button

@export var target_menu : MenuBase

func _ready():
	self.pressed.connect(target_menu.open_menu)
