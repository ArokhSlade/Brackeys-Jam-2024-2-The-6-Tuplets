extends Node3D

@export var scene_path = GlobalGameState.game_over_scene_path
@export var was_game_won: bool


func _on_area_3d_body_entered(_body):
	GlobalGameState.was_game_won = was_game_won;
	get_tree().call_deferred("change_scene_to_file",scene_path)	
