extends CharacterBody2D

@export var speed = 400
@export var atk_growth_per_level = 100.0
@export var hp_growth_per_level = 100.0
@export var speed_run = 800

var screen_size
var level = 1
var atk = level * atk_growth_per_level
var hp = level * hp_growth_per_level
var is_running = false
var latest_orientation = Vector2.ZERO

func _player_attack () -> void:
	pass #So far no idea how to implement combat system, gonna try later
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_get_latest_orientation()
	is_running = false
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("run"):
		is_running = true
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("attack_melee"):
		_slash_attack()
		
		
	if is_running:
		velocity = velocity.normalized() * speed_run
		$PlayerAnimation.play("run")
	elif Input.is_action_pressed("move_down") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up"):
		velocity = velocity.normalized() * speed
		$PlayerAnimation.play("walk")
	else:
		$PlayerAnimation.play("idle")	
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		print("enterd")
	pass # Replace with function body.


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		print("left")
	pass # Replace with function body.

func _player_being_hit (damage : int, attacker : Node2D) -> Node2D:
	hp -= damage
	print("Being hit! HP - " + str(damage) + ", has " + str(hp) + " left.")
	return attacker

func _get_latest_orientation () -> void:
	var input_dir = Vector2.ZERO
	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_dir = input_dir.normalized()
	
	if input_dir != Vector2.ZERO:
		latest_orientation = input_dir
	else:
		latest_orientation = Vector2.ZERO
	
func _slash_attack() -> void:
	$AttackHitbox/CollisionShape2D.global_position = global_position + latest_orientation * 140
	$AttackHitbox/CollisionShape2D.rotation = latest_orientation.angle()
	if !Input.is_action_pressed("attack_melee"):
		$AttackHitbox/CollisionShape2D.global_position = Vector2.ZERO
		$AttackHitbox/CollisionShape2D.rotation = Vector2.ZERO.angle()
	# Optionally resize hitbox if it has a CollisionShape2D child
	#var shape = hitbox.get_node_or_null("CollisionShape2D")
	#if shape and shape.shape is RectangleShape2D:
		#shape.shape.extents = hitbox_size / 2

	# Schedule deletion after duration
