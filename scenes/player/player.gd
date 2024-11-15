extends CharacterBody3D

@export var jumpForce = 30.0 
@export var gravity = 90.0  
@export var fall_multiplier = 0.5  
@export var max_jumps = 2  
@export var speed: float = 8.0
@export var rotation_speed: float = 20.0
@export var player_health: int = 3

var outside_level_position = Vector3(0,0,100) #behind camera
@onready var step_sounds = AudioController.steps_sandstone

signal motion_updated
signal died

var motion : GlobalGameState.Motion = GlobalGameState.Motion.IDLE

func _ready():
	add_to_group("Player")	
	_update_health_label()

var jump_count = 0
var player_velocity: Vector3 = Vector3.ZERO

func _process(delta: float) -> void:
	_handle_input(delta)
	_apply_gravity(delta)
	_apply_movement()
	_check_for_landing()
	_footstep_sounds()
	_set_animation()

func _set_animation():
	
	if !is_on_floor():
		motion = GlobalGameState.Motion.JUMP
	elif player_velocity.length_squared() > 0.01:
		motion = GlobalGameState.Motion.RUN
	else:
		motion = GlobalGameState.Motion.IDLE
	motion_updated.emit(motion)
	
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
		

# FOOTSTEP SOUND LOGIC 
func _footstep_sounds() -> void:
	if is_on_floor() and player_velocity.x != 0:
		if $FootstepTimer.time_left <=0 :
			#AudioController.play_stepDirt()
			var random_index = randi_range(0,step_sounds.size()-1)
			$StepSoundsPlayer.stream = step_sounds[random_index]
			$StepSoundsPlayer.play()
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
	
	var collision = get_last_slide_collision()
	#var last_collision_count = collision.get_collision_count()
	if collision:	
		var collider = collision.get_collider() as Node
		if collider.is_in_group("terrain"):
			var terrain_type = collider.terrain_type
			step_sounds = AudioController.steps_dictionary[terrain_type]
	
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
	
func on_enemy_hit_with_feet(enemy: Node3D) -> void:	
	enemy.die()

func _update_health_label():
	$HealthLabel.text = "HP: %d" % [player_health]

func _on_take_damage_body_entered(body: Node3D) -> void:
	player_health -=1
	_update_health_label()
	if player_health == 0:
		die()
		
func die():
	died.emit()
	position = outside_level_position
