extends CharacterBody2D

var speed = 100
var player_entred = false	
var player = null	
var isOnCooldown = false
var player_in_attack_range = false
var hp = 20

func _on_routing_ai_body_entered(body: Node2D) -> void:
	player_entred = true
	player = body


func _on_routing_ai_body_exited(body: Node2D) -> void:
	player_entred = false
	player = null

func _physics_process(delta: float) -> void:
	if player_entred:
		position += (player.position - position) / speed
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
	if player_in_attack_range:
		_enemy_attack()

func _enemy_attack () -> void:
	if player.has_method("_player_being_hit") && isOnCooldown == false:
		player._player_being_hit(10)
		isOnCooldown = true
		$EnemyAttackCooldown.start()


func _on_enemy_attack_cooldown_timeout() -> void:
	isOnCooldown = false


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("_player_being_hit"):
		player_in_attack_range = true


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("_player_being_hit"):
		player_in_attack_range = false

func _enemy_being_hit (damage : int) -> void:
	hp -= damage
	print("Enemy being hit! HP - " + str(damage) + ", has " + str(hp) + " left.")
	if hp <= 0:
		self.queue_free()
