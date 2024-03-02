extends CharacterBody2D

const SPEED = 150.0
const JUMP_FORCE = -400.0
var current_dir = "none"
var jumping = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(_delta):
	if not is_on_floor():
		velocity.y += gravity * _delta
		jumping = true
	if is_on_floor():
		jumping = false
		
	_move_system(_delta)

func _move_system(_delta):
	if Input.is_action_pressed("move_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = SPEED
	elif Input.is_action_pressed("move_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -SPEED
	else:
		play_anim(0)
		velocity.x = 0
	if Input.is_action_just_pressed("jump") and !jumping:
		velocity.y = JUMP_FORCE
		
	move_and_slide()
	
func play_anim(movement):
	var dir = current_dir
	var anim = $sprites
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("move")
		elif movement == 0:
			anim.play("idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("move")
		elif movement == 0:
			anim.play("idle")

