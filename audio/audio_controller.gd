extends Node


## how to add audio: 
## create AudioStreamPlayer2D, assign a stream
## create function in this script to play it
## add AudioController.fucntionname.play() to relevant part of other script
## ???
## profit

## useful notes: setting the stream to AudioStreamRandomizer allows you to randomize between
## multiple sounds and give each sound a random pitch and volume. 

@export var ambiance_clips : Array 
@export var test_clips : Array 
@export var menu_music : AudioStream
@export var steps_dirt: Array
@export var steps_sand: Array
@export var steps_sandstone: Array
@export var steps_wood: Array
@export var steps_gravel: Array

const SANDSTONE = GlobalGameState.TerrainType.SANDSTONE
const SAND = GlobalGameState.TerrainType.SAND
const WOOD = GlobalGameState.TerrainType.WOOD
const DIRT = GlobalGameState.TerrainType.DIRT
const GRAVEL = GlobalGameState.TerrainType.GRAVEL

@export var steps_dictionary : Dictionary 

@onready var background_player = $BackgroundClipPlayer

func _ready():
	background_player.stream = menu_music
	steps_dictionary = {
		SANDSTONE : steps_sandstone,
		SAND : steps_sand,
		GRAVEL : steps_gravel,
		WOOD : steps_wood,
		DIRT : steps_dirt	
	}
	

func play_menuMusic():
	$menuMusic.play()

func stop_menuMusic():
	$menuMusic.stop()

func play_gameAmbience1():
	$gameAmbience1.play()

func play_gameAmbience2():
	$gameAmbience2.play()

func play_gameAmbience3():
	$gameAmbience3.play()

func play_gameAmbience4():
	$gameAmbience4.play()

func play_endscreenMusic1():
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
