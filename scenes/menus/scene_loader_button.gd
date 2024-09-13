class_name SceneLoaderButton
extends Button

var scene_path : String


func _on_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(scene_path)
