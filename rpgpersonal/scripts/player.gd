extends CharacterBody2D


const SPEED = 250.0
var current_direction = "none"

func _ready():
	$AnimatedSprite2D.play("FrontIdle");

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		play_anim(1)
		velocity.x = SPEED
		velocity.y = 0
	
	elif Input.is_action_pressed("ui_left"):
		current_direction = "left"
		play_anim(1)
		velocity.x = -SPEED
		velocity.y = 0
		
	elif Input.is_action_pressed("ui_up"):
		current_direction = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -SPEED
		
	elif Input.is_action_pressed("ui_down"):
		current_direction = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = SPEED
	
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0 
	
	move_and_slide()
	
func play_anim(movement):
	var dir = current_direction
	var animation = $AnimatedSprite2D
	
	if dir == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("SideWalk")
		elif movement == 0:
			animation.play("SideIdle")
			
	if dir == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("SideWalk")
		elif movement == 0:
			animation.play("SideIdle")
			
	if dir == "up":
		animation.flip_h = true
		if movement == 1:
			animation.play("BackWalk")
		elif movement == 0:
			animation.play("BackIdle")
			
	if dir == "down":
		animation.flip_h = true
		if movement == 1:
			animation.play("FrontWalk")
		elif movement == 0:
			animation.play("FrontIdle")
