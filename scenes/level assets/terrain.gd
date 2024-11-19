extends StaticBody3D

const TerrainType = preload("res://scenes/level assets/TerrainType.gd")

@export var terrain_type : GlobalGameState.TerrainType = GlobalGameState.TerrainType.SANDSTONE

const SANDSTONE = GlobalGameState.TerrainType.SANDSTONE
const SAND = GlobalGameState.TerrainType.SAND
const WOOD = GlobalGameState.TerrainType.WOOD
const DIRT = GlobalGameState.TerrainType.DIRT
const GRAVEL = GlobalGameState.TerrainType.GRAVEL

const GRAVEL_MATERIAL = preload("res://materials/gravel.tres")
const SAND_MATERIAL = preload("res://materials/sand.tres")
const SANDSTONE_MATERIAL = preload("res://materials/sandstone.tres")
const WOOD_MATERIAL = preload("res://materials/wood.tres")
const DIRT_MATERIAL = preload("res://materials/dirt.tres")
