extends Node3D

var idle = true

@onready var ani = $AnimationPlayer
var last_motion : GlobalGameState.Motion  = GlobalGameState.Motion.IDLE

func stop():
	ani.stop()

func jump():		
	ani.speed_scale = .1
	ani.play()
	
func run():
	ani.speed_scale = 1
	ani.play()
	

func _ready():	
	ani.current_animation = "ArmatureAction_002"
	ani.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_motion_updated(motion):
	#var motion_changed = motion != last_motion
	#if motion_changed:
	if motion == GlobalGameState.Motion.IDLE:
		stop()
	elif motion == GlobalGameState.Motion.RUN:
		run()
	elif motion == GlobalGameState.Motion.JUMP:
		jump()
	
