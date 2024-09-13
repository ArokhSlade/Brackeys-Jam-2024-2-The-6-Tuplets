extends Node

var materials_required_count = 4
var was_game_won = false

enum Motion {IDLE, RUN, JUMP} # TODO(Arokh):where would this live?

#used by main menu and game over menu
const level_path = "res://scenes/level assets/level.tscn"
const game_over_scene_path = "res://scenes/menus/game_over_scene.tscn"
const main_menuscene_path = "res://scenes/menus/main_menu_scene.tscn"
