extends MeshInstance3D

const TerrainType = preload("res://scenes/level assets/TerrainType.gd")

@export var terrain_type : GlobalGameState.TerrainType = GlobalGameState.TerrainType.SANDSTONE

const SANDSTONE = GlobalGameState.TerrainType.SANDSTONE
const SAND = GlobalGameState.TerrainType.SAND
const WOOD = GlobalGameState.TerrainType.WOOD
const DIRT = GlobalGameState.TerrainType.DIRT
const GRAVEL = GlobalGameState.TerrainType.GRAVEL

const GRAVEL_MATERIAL = preload("res://materials/GRAVEL.tres")
const SAND_MATERIAL = preload("res://materials/SAND.tres")
const SANDSTONE_MATERIAL = preload("res://materials/SANDSTONE.tres")
const WOOD_MATERIAL = preload("res://materials/WOOD.tres")
const DIRT_MATERIAL = preload("res://materials/DIRT.tres")

func _ready():	
	if terrain_type == SANDSTONE:
		material_override = SANDSTONE_MATERIAL
	elif terrain_type == SAND:
		material_override = SAND_MATERIAL
	elif terrain_type == WOOD:
		material_override = WOOD_MATERIAL
	elif terrain_type == DIRT:
		material_override = DIRT_MATERIAL
	elif terrain_type == GRAVEL:
		material_override = GRAVEL_MATERIAL
