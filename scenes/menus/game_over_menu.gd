extends MenuBase

func _ready():
	$Contents/GameOverMessage.text = "Congrats\nYou Won!" if GlobalGameState.was_game_won else "Oof, You Lost :("
