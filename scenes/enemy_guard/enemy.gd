extends CharacterBody3D

@export var patrol_speed = 4.0
@export var chase_speed = 4.0 
@export var change_direction_interval: float = 3.0 
@export var chase_range: float = 15.0
@export var attack_range: float = 2.0
@export var attack_cooldown: float = 1.0 
@export var return_to_patrol_delay: float = 2.0 
@export var ignore_player_delay: float = 2.0 

var player: CharacterBody3D
var ai_velocity = Vector3.ZERO
var gravity = -9.8 
var movingLeft: bool = false
var attack_timer = 0.0
var wait_timer = 0.0 

#ENEMY WILL GO BACK TO PATROL IF PALYER IS NOT MOVING AND IS FAR FROM ATTACK RANGE
var ignore_player_timer = 0.0 

enum AIState { PATROL, CHASE, ATTACK, RETURN }
var current_state = AIState.PATROL

func _ready():
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		player = players[0] as CharacterBody3D 
		

func _physics_process(delta):
	_update_state(delta)
	
	if current_state == AIState.PATROL:
		_patrol(delta)
	elif current_state == AIState.CHASE:
		_chase(delta)
	elif current_state == AIState.ATTACK:
		_attack(delta)
	elif current_state == AIState.RETURN:
		_return_to_patrol(delta)
	
	_apply_gravity(delta)
	velocity = ai_velocity
	move_and_slide()
	_rotate_to_movement_direction()

func _update_state(delta):
	if player != null:
		var distance_x = abs(global_transform.origin.x - player.global_transform.origin.x)
		var distance_y = abs(global_transform.origin.y - player.global_transform.origin.y)
		
		var player_velocity = player.velocity  
		var is_player_moving = player_velocity.length() > 0

		if is_on_floor():
			if is_player_moving:
				ignore_player_timer = 0.0 
				if distance_x < attack_range and distance_y < attack_range:
					current_state = AIState.ATTACK
					wait_timer = 0.0  
					
				elif distance_x < chase_range and distance_y < chase_range and player.global_transform.origin.y >= global_transform.origin.y:
					current_state = AIState.CHASE
					wait_timer = 0.0  
				else:
					if current_state == AIState.CHASE or current_state == AIState.ATTACK:
						wait_timer += delta
						if wait_timer >= return_to_patrol_delay:
							current_state = AIState.PATROL
							wait_timer = 0.0 
			else:
				ignore_player_timer += delta
				if ignore_player_timer >= ignore_player_delay:
					current_state = AIState.PATROL
					ignore_player_timer = 0.0 


func _patrol(delta):
	if movingLeft:
		ai_velocity.x = -patrol_speed  
	else:
		ai_velocity.x = patrol_speed  
	ai_velocity.z = 0  

func _chase(delta):
	if player and is_on_floor():
		var direction = (player.global_transform.origin - global_transform.origin).normalized()
		direction.y = 0 
		ai_velocity = direction * chase_speed  
		ai_velocity.z = 0 

		if abs(global_transform.origin.x - player.global_transform.origin.x) < attack_range and abs(global_transform.origin.y - player.global_transform.origin.y) < attack_range:
			current_state = AIState.ATTACK
		else:
			if player.global_transform.origin.y < global_transform.origin.y:
				current_state = AIState.RETURN

func _attack(delta):
	if player != null:
		attack_timer += delta
		
		if attack_timer >= attack_cooldown:
			attack_timer = 0.0
			
			if player != null:
				if abs(global_transform.origin.x - player.global_transform.origin.x) < chase_range and abs(global_transform.origin.y - player.global_transform.origin.y) < chase_range:
					current_state = AIState.CHASE
		
			if abs(global_transform.origin.x - player.global_transform.origin.x) > chase_range and abs(global_transform.origin.y - player.global_transform.origin.y) > chase_range:
				wait_timer += delta
			if wait_timer >= return_to_patrol_delay:
				current_state = AIState.PATROL
				wait_timer = 0.0  

func _return_to_patrol(delta):
	_patrol(delta)

func _apply_gravity(delta):
	if not is_on_floor():
		ai_velocity.y += gravity * delta
	else:
		ai_velocity.y = 0
	ai_velocity.x = clamp(ai_velocity.x, -patrol_speed, patrol_speed)

func _rotate_to_movement_direction():
	if ai_velocity.length() > 0:
		var direction = ai_velocity.normalized()
		var angle = atan2(direction.z, direction.x)  
		global_transform.basis = Basis(Vector3.UP, angle)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == self: 
		movingLeft = not movingLeft
