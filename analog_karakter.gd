extends CharacterBody2D

const speed = 100
var current_dir = "none"

func _physics_process(delta):
	analog(delta)

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

func animasi(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
	elif dir == "left":
		anim.flip_h = true
	
	if movement == 1:
		anim.play("Run")
	elif movement == 0:
		anim.play("Idle")
