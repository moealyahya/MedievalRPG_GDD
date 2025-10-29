extends Node

var player_current_attack = false 

var current_scene = "World"
var transition_scene = false

var player_exit_dungeon1_posx = 0
var player_exit_dungeon1_poy = 0
var player_start_posx = 0
var player_start_posy = 0

func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "World":
			current_scene = "dungeon_1"
		else:
			current_scene = "World"
