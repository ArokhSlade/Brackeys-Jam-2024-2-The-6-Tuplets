extends CharacterBody3D

@export var jumpForce = 30.0 
@export var gravity = 90.0  
@export var fall_multiplier = 0.5  
@export var max_jumps = 2  
@export var speed: float = 8.0
@export var rotation_speed: float = 20.0

func _ready():
	add_to_group("Player")
	## changes music that's playing to game music
	AudioController.stop_menuMusic()
	AudioController.play_gameMusic1()

var jump_count = 0
var player_velocity: Vector3 = Vector3.ZERO

func _process(delta: float) -> void:
	_handle_input(delta)
	_apply_gravity(delta)
	_apply_movement()
	_check_for_landing()
	_footstep_sounds()

# INPUT CONTROLLERS
func _handle_input(delta: float) -> void:
	var input_direction: Vector3 = Vector3.ZERO

	if Input.is_action_pressed("move_left"):
		input_direction.x -= 1

	if Input.is_action_pressed("move_right"):
		input_direction.x += 1

	if input_direction.length() > 0:
		input_direction = input_direction.normalized()
	
	player_velocity.x = input_direction.x * speed

	if Input.is_action_just_pressed("Jump"):
		_handle_jump()
	_update_rotation(input_direction)

# JUMP LOGIC
func _handle_jump() -> void:
	if is_on_floor() or jump_count < max_jumps:
		player_velocity.y = jumpForce 
		jump_count += 1
		AudioController.play_jump()
		

# TO DO: CHANGE FOOTSTEP SOUND BASED ON MATERIAL TYPE
# FOOTSTEP SOUND LOGIC 
func _footstep_sounds() -> void:
	if is_on_floor() and player_velocity.x != 0:
		if $FootstepTimer.time_left <=0 :
			AudioController.play_stepDirt()
			$FootstepTimer.start(.5)

# GRAVITY
func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		#IF THE PLAYER IS FALLING
		if player_velocity.y < 0:  
			# INCREASE GRAVITY 
			player_velocity.y -= gravity * fall_multiplier * delta
		else:
			#NORMAL GRAVITY  
			player_velocity.y -= gravity * delta
	else:
		if player_velocity.y < 0:  
			player_velocity.y = 0

# MOVEMENT
func _apply_movement() -> void:
	velocity = player_velocity 
	move_and_slide()

# RESET JUMP COUNT WHEN LANDING
func _check_for_landing() -> void:
	if is_on_floor():
		if jump_count > 0:
			jump_count = 0  
			

# ROTATION FUNCTION
func _update_rotation(input_direction: Vector3) -> void:
	if input_direction != Vector3.ZERO:
		var target_rotation = Basis(Vector3.UP, input_direction.x).rotated(Vector3.UP, -PI/2)
		rotation = rotation.slerp(target_rotation.get_euler(), rotation_speed * get_process_delta_time())
	
