extends Camera3D

@export var deadzone_x_left: float = 5.0  
@export var deadzone_x_right: float = 5.0  
@export var deadzone_y_top: float = 3.0 
@export var deadzone_y_bottom: float = 2.0 

@export var player: CharacterBody3D

var player_last_y: float = 0.0  

func _ready() -> void:
	if player:
		player_last_y = player.global_transform.origin.y 
	else:
		return

func _process(delta: float) -> void:
	if player:
		update_camera_position()

func update_camera_position():
	
	var player_position = player.global_transform.origin
	var camera_position = global_transform.origin
	var target_position = camera_position

	# DEAD ZONE HORIZONTAL MOVEMENT X-AXIS
	if player_position.x < camera_position.x - deadzone_x_left:
		target_position.x = player_position.x + deadzone_x_left
	elif player_position.x > camera_position.x + deadzone_x_right:
		target_position.x = player_position.x - deadzone_x_right

	# DEAD ZONE VERTICAL MOVEMENT Y- AXIS
	if player_position.y > camera_position.y + deadzone_y_top:
		target_position.y = player_position.y
	elif player_position.y < camera_position.y - deadzone_y_bottom:
		target_position.y = player_position.y

	#CAMERA SPEED TO TARGET POSITION
	global_transform.origin = global_transform.origin.lerp(target_position, 0.05)

	
	#print("Camera Position:", global_transform.origin)
	#print("Player Position:", player_position)
	#print("Target Position:", target_position)

	# UPDATE LAST PLAYER POSITION
	player_last_y = player_position.y
