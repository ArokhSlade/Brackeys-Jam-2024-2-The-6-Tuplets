extends Node3D

@export var required_count : int
@export var delivered_count : int = 0
@export var build_stage_meshes : Array
var current_mesh
@onready var current_mesh_node = $CurrentBuildMesh

func _ready():
	advance_construction()
	
func receive_materials(count=1):
	print("materials delivered: ", count)
	delivered_count += count
	delivered_count = clampi(delivered_count,0,required_count)
	advance_construction()

func advance_construction():
	current_mesh = build_stage_meshes[delivered_count]
	current_mesh_node.mesh = current_mesh
	
