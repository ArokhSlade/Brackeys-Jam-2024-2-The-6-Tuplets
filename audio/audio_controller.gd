extends Node2D

## how to add audio: 
## create AudioStreamPlayer2D, assign a stream
## create function in this script to play it
## add AudioController.fucntionname.play() to relevant part of other script
## ???
## profit

## useful notes: setting the stream to AudioStreamRandomizer allows you to randomize between
## multiple sounds and give each sound a random pitch and volume. 

func _ready():
	play_menuMusic()

func play_menuMusic():
	$menuMusic.play()

func stop_menuMusic():
	$menuMusic.stop()

func play_gameMusic1():
	$gameMusic1.play()

func play_gameMusic2():
	$gameMusic2.play()

func play_gameMusic3():
	$gameMusic3.play()

func play_endscreenMusic():
	$endscreenMusic.play()

func play_jump():
	$jump.play()

func play_stepDirt():
	$stepDirt.play()

func play_stepSand():
	$stepSand.play()

func play_stepSandstone():
	$stepSandstone.play()

func play_stepWood():
	$stepWood.play()

func play_ambience():
	$ambience.play()
