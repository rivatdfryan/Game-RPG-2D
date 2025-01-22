extends CharacterBody2D

const speed = 100
var current_dir = "none"
var jump = -300
var is_attack = false

func _physics_process(delta):
	if is_attack:
		if !$AnimatedSprite2D.is_playing() or $AnimatedSprite2D.animation != "Attack1":
			is_attack = false
		return

	analog(delta)
	lompat()

func analog(delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		current_dir = "right"
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		current_dir = "left"
	if Input.is_action_pressed("ui_down"):
		velocity.y += speed
		current_dir = "down"
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
		current_dir = "up"

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		animasi(1)
	else:
		animasi(0) 

	move_and_slide()

func lompat():
	if Input.is_action_just_pressed("ui_shift"):
		velocity.y = jump
		animasi("Jump")
		current_dir = "Jump"

func serang():
	if Input.is_action_just_pressed("ui_x") and not is_attack:
		is_attack = true
		animasi("Attack1")
		current_dir = "Attack"

func animasi(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if is_attack:
		anim.play("Attack1")
		return  # Skip other animations if attacking

	if dir == "right":
		anim.flip_h = false
	elif dir == "left":
		anim.flip_h = true
	elif dir == "Jump":
		anim.play("Jump")
		return  # Skip other animations if jumping

	if movement == 1:
		anim.play("Run")
	elif movement == 0:
		anim.play("Idle")
