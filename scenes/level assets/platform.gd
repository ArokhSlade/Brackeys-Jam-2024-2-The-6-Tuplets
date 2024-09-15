extends StaticBody3D

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

@export var collision_shape : Shape3D
@export var mesh : Mesh

func _ready():
	$CollisionShape3D.shape = collision_shape
	$MeshInstance3D.mesh = mesh
	if terrain_type == SANDSTONE:
		$MeshInstance3D.material_override = SANDSTONE_MATERIAL
	elif terrain_type == SAND:
		$MeshInstance3D.material_override = SAND_MATERIAL
	elif terrain_type == WOOD:
		$MeshInstance3D.material_override = WOOD_MATERIAL
	elif terrain_type == DIRT:
		$MeshInstance3D.material_override = DIRT_MATERIAL
	elif terrain_type == GRAVEL:
		$MeshInstance3D.material_override = GRAVEL_MATERIAL
	$MeshInstance3D.material_override
