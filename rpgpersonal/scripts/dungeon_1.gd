extends Node2D 

func _process(delta): 
	change_scene() 

func _on_dungeon_exit_body_entered(body): 
	if body.has_method("player"): 
		Global.transition_scene = true 
		Global.next_scene = "world" 
	
func _on_dungeon_exit_body_exited(body): 
	if body.has_method("player"): 
		Global.transition_scene = false 

func change_scene(): 
	if Global.transition_scene and Global.next_scene == "world": 
		get_tree().change_scene_to_file("res://scenes/world.tscn") 
		Global.finish_changescenes()
