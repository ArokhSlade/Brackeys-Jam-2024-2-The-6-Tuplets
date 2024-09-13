extends Node3D

signal entered_game_over_zone

@export var scene_path = GlobalGameState.game_over_scene_path
@export var was_game_won: bool


func _on_area_3d_body_entered(_body):
	entered_game_over_zone.emit()
