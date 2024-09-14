extends Node

@onready var build_site = $BuildSite
@onready var past_game_timer = $PastGameTimer
@onready var storm_timer = $StormTimer
@export var  time_limit : float
@export var win_message = "Hooray! Takah prevailed (for now) ..."
@export var lose_message = "Shoot! Take didn't make it ... "


@onready var timer_label = %TimerLabel
@onready var game_over_label = %GameOverLabel

func update_progress_label():
	%ProgressLabel.text = "%d / %d" % [build_site.received_count, build_site.required_count]

func _ready():
	storm_timer.start(time_limit)
	GlobalGameState.was_game_won = false
	update_progress_label()
	game_over_label.hide()

func _process(delta):	
	if !storm_timer.is_stopped():
		timer_label.text = "%.2f" % storm_timer.time_left

func win_game():
	GlobalGameState.was_game_won = true
	storm_timer.stop()
	past_game_timer.start()
	game_over_label.text = win_message
	game_over_label.show()
	
func lose_game():
	GlobalGameState.was_game_won = false
	past_game_timer.start()
	game_over_label.text = lose_message
	game_over_label.show()

func _on_past_game_timer_timeout():	
	get_tree().call_deferred("change_scene_to_file",GlobalGameState.game_over_scene_path)


func _on_build_site_material_received():	
	update_progress_label()
	if build_site.received_count >= build_site.required_count:
		if not GlobalGameState.was_game_won:
			win_game()
