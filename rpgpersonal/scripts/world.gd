extends Node2D

func _ready():
	if Global.When_Game_first_loads_In:
		$Player.position.x = Global.player_start_posx
		$Player.position.y = Global.player_start_posy
	else:
		match Global.current_scene:
			"dungeon_1":
				$Player.position.x = Global.player_exit_dungeon1_posx
				$Player.position.y = Global.player_exit_dungeon1_posy
			"dungeon_2":
				$Player.position.x = Global.player_exit_dungeon2_posx
				$Player.position.y = Global.player_exit_dungeon2_posy


func _process(delta):
	change_scene()

func _on_dungeon_1_transition_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true
		Global.next_scene = "dungeon_1"  

func _on_dungeon_1_transition_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false
		
func _on_dungeon_2_transition_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true
		Global.next_scene = "dungeon_2" 

func _on_dungeon_2_transition_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false

func change_scene():
	if Global.transition_scene:
		Global.current_scene = Global.next_scene 
		if Global.next_scene == "dungeon_1":
			Global.player_exit_dungeon1_posy = $Player.position.y
			Global.player_exit_dungeon1_posx = $Player.position.x
			get_tree().change_scene_to_file("res://scenes/dungeon_1.tscn")
			
		elif Global.next_scene == "dungeon_2":
			Global.player_exit_dungeon2_posy = $Player.position.y
			Global.player_exit_dungeon2_posx = $Player.position.x
			get_tree().change_scene_to_file("res://scenes/dungeon_2.tscn")
			
		Global.When_Game_first_loads_In = false
		Global.finish_changescenes()
