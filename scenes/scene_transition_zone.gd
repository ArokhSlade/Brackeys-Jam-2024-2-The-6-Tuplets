extends Node3D

@export var scene_path = "res://scenes/game_over.tscn"
@export var was_game_won: bool


	


func _on_area_3d_body_entered(_body):
	print("WON? ", was_game_won)
	TestGlobalData.was_game_won = was_game_won;
	get_tree().change_scene_to_file(scene_path)
