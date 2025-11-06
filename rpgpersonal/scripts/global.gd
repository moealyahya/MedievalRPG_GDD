extends Node

var player_current_attack = false 

var current_scene = "World"
var transition_scene = false
var next_scene = ""

var player_exit_dungeon1_posx = 1125
var player_exit_dungeon1_posy = 32
var player_exit_dungeon2_posx = 2919
var player_exit_dungeon2_posy = 189
var player_start_posx = 51
var player_start_posy = 87

var When_Game_first_loads_In = true

func finish_changescenes():
	if transition_scene:
		transition_scene = false
		current_scene = next_scene
