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
