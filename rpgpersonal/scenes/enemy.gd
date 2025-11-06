extends CharacterBody2D

var speed = 60
var chasing_player = false
var player = null

func _physics_process(delta):
	if chasing_player:
		position += (player.position - position) / speed
		$AnimatedSprite2D.play("moving")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
	else:
		$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	chasing_player = true

func _on_detection_area_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player = null
	chasing_player = false 
