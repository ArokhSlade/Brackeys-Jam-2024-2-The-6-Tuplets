extends Node3D

signal material_received

@onready var required_count = GlobalGameState.materials_required_count
@export var received_count : int = 0
@export var build_stages : Array
var current_stage
@onready var current_stage_node = $CurrentBuildMesh

func _ready():
	advance_construction()
	assert(build_stages.size() >= required_count + 1) #NOTE(arokh): +1 for "no materials"
	
	
func receive_materials(count=1):
	received_count += count	
	received_count = clampi(received_count,0,required_count)
	material_received.emit()
	advance_construction()

func advance_construction():
	if received_count > 0:
		if (current_stage): 
			current_stage.queue_free()
		current_stage = build_stages[received_count].instantiate()
		add_child(current_stage)
	
