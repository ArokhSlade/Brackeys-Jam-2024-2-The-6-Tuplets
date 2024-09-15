extends Node3D

signal material_received

var required_count #gets filled by Level
@export var received_count : int = 0
@export var build_stages : Array
var current_upgrade = 0
var items_per_upgrade # how many materials before the mesh evolves
var items_for_last_upgrade
@onready var current_upgrade_node = $CurrentBuildMesh
@onready var max_upgrades = build_stages.size()
var items_till_next_upgrade

func initialize(required_count_): #called by Manager during _ready()
	required_count = required_count_
	items_per_upgrade = required_count / max_upgrades 
	items_for_last_upgrade = items_per_upgrade + (required_count % max_upgrades)
	items_till_next_upgrade = items_for_next_uprade()


func items_for_next_uprade() -> int:
	var result : int = 0
	if current_upgrade == max_upgrades - 1:
		result = items_for_last_upgrade
	else : 
		result = items_per_upgrade
	return result


func _ready():
	#advance_construction()
	pass
	
	
func receive_materials(count=1):
	
	received_count += count	
	received_count = clampi(received_count,0,required_count)
	material_received.emit() # not used so far
	
	items_till_next_upgrade -= count
	while items_till_next_upgrade <= 0:		
		advance_construction()
		items_till_next_upgrade += items_for_next_uprade()

func advance_construction():
	#if received_count > 0:
	if (current_upgrade_node): 
		current_upgrade_node.queue_free()
		current_upgrade_node = build_stages[current_upgrade].instantiate()
	add_child(current_upgrade_node)
	current_upgrade += 1
	
