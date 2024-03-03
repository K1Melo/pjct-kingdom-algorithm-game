extends CharacterBody2D

#player movement variable
@export var speed = 150
@export var gravity = 500
@export var jump_height = -250

#jump states
var is_jumping:bool = false

func _physics_process(delta):
	velocity.y += gravity * delta
	
	_movement()
	move_and_slide() 

func _movement():
	var _input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = _input * speed
	play_anim()
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			is_jumping = true
			velocity.y = jump_height
			play_anim()

func play_anim():
	var _anim = $sprites
	
	#Idle animation
	if !Input.is_anything_pressed() && !is_jumping:
		_anim.play("idle")
		
	if !is_jumping:
		#Right animation
		if Input.is_action_pressed("move_right"):
			_anim.play("move")
			_anim.flip_h = false
		#Left animation
		if Input.is_action_pressed("move_left"):
			_anim.flip_h = true
			_anim.play("move")
			
	if !is_on_floor():
		if velocity.y < 0:
			$sprites.play("jump")
		else:
			$sprites.play("fall")

func _on_sprites_animation_finished():
	is_jumping = false
