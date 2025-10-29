extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()

func _on_dungeon_1_transition_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = true

func _on_dungeon_1_transition_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = false

func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "World":
			get_tree().change_scene_to_file("res://scenes/dungeon_1.tscn")
			Global.finish_changescenes()
