extends Area2D

var speed = 20
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = (get_viewport().get_mouse_position() - get_parent().global_position).normalized()
	self.rotation = direction.angle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("_enemy_being_hit"):
		body._enemy_being_hit(5)
		self.queue_free()
	#elif body.has_method("_player_being_hit"):
		#body._player_being_hit(5)
		#self.queue_free()
		
