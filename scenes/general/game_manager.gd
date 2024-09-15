extends Node

@onready var build_site = $BuildSite
@onready var past_game_timer = $PastGameTimer
@onready var storm_timer = $StormTimer
var  time_limit : float
@export var win_message = "Hooray! Takah prevailed (for now) ..."
@export var lose_message = "Shoot! Takah didn't make it ... "
@export var segment_counts : Array = [1,1,1,1]

@onready var timer_label = %TimerLabel
@onready var game_over_label = %GameOverLabel
@onready var ambiance_timer = $AmbianceTimer
@onready var debug_ambiance_label = $DebugCanvas/AmbianceLabel

var current_clip_play_count = 0
var current_segment_index = 0
@onready var bgm_clips = AudioController.ambiance_clips
#@onready var bgm_clips = AudioController.test_clips

func debug_update_ambiance_label():
	debug_ambiance_label.text = "Ambiance: %.1f" % ambiance_timer.time_left
	
func _on_clip_finished_playing():
		current_clip_play_count += 1
		
		if current_segment_index < segment_counts.size() - 1:
			if current_clip_play_count >= segment_counts[current_segment_index]:			
				current_segment_index += 1
				current_clip_play_count = 0
				var current_clip = bgm_clips[current_segment_index]
				AudioController.background_player.stream = current_clip				
				ambiance_timer.start(current_clip.get_length())
		
		AudioController.background_player.play()
		
		
			
		

func _ready():
	time_limit = 0
	for i in segment_counts.size():
		time_limit += segment_counts[i] * 30 #all segments are 30sec
	
	AudioController.background_player.stream = bgm_clips[0]	
	ambiance_timer.wait_time = AudioController.background_player.stream.get_length()
	AudioController.background_player.play()	
	ambiance_timer.one_shot = false
	ambiance_timer.start()
	
	
	storm_timer.start(time_limit)
	GlobalGameState.was_game_won = false
	update_progress_label()
	game_over_label.hide()
		
	
	

func _process(delta):	
	if !storm_timer.is_stopped():
		timer_label.text = "%.2f" % storm_timer.time_left
	debug_update_ambiance_label()

func win_game():
	GlobalGameState.was_game_won = true
	storm_timer.stop()
	past_game_timer.start()
	game_over_label.text = win_message
	game_over_label.show()

func update_progress_label():
	%ProgressLabel.text = "%d / %d" % [build_site.received_count, build_site.required_count]
	
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
