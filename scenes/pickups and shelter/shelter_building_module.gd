class_name ShelterBuildingModule
extends Node

@export var carrying_count : int = 0
@export var carrying_capacity : int = 1
@onready var materials_label = %MaterialsLabel

func _ready():
	update_materials_label()

func pick_up_material(material : Area3D):
	if carrying_count < carrying_capacity:
		carrying_count += 1		
		update_materials_label()
		material.queue_free()
	
func drop_off_material(build_site : Area3D):
	if carrying_count > 0:
		carrying_count -= 1		
		update_materials_label()
		build_site.owner.receive_materials()

func _on_detector_area_entered(area):
	if area.is_in_group("building_materials"):
		pick_up_material(area)
	if area.is_in_group("build_site"):
		drop_off_material(area)

func update_materials_label():
	materials_label.text = "%d / %d" % [carrying_count, carrying_capacity]
