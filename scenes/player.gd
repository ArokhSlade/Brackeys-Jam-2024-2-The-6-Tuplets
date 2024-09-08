extends Node3D

@export var speed = 5

@onready var rigid_body = $RigidBody3D

func _ready():
	pass # Replace with function body.



func _physics_process(_delta):	
	var new_velocity = Vector3.ZERO
	var input_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	new_velocity.x += speed * input_x
	rigid_body.linear_velocity = new_velocity
	
