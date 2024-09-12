extends Node

@onready var build_site = $BuildSite

func _process(delta):
	if build_site.delivered_count == build_site.required_count:
		win_game()

func win_game():
	GlobalGameState.was_game_won = true
	get_tree().call_deferred("change_scene_to_file",GlobalGameState.game_over_scene_path)
