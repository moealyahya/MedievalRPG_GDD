class_name Player
extends Area2D

@export var speed = 400
@export var atk_growth_per_level = 1.0
@export var hp_growth_per_level = 1.0
@export var speed_run = 800

var screen_size
var level = 1
var atk = level * atk_growth_per_level
var hp = level * hp_growth_per_level
var is_running = false
	
func playerAttack () -> void:
	pass #So far no idea how to implement combat system, gonna try later
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
