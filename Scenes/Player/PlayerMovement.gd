extends KinematicBody2D

export (int) var speed = 200
var velocity = Vector2()

onready var target = position
var isMouse = true

func get_input():

	velocity = Vector2()

	#maus

	if Input.is_action_pressed("clicky"):
		target = get_global_mouse_position()
		isMouse = true
		velocity = position.direction_to(target)*speed

		if velocity.x>0:
			$PlayerSprite.flip_h=false
		elif velocity.x<0:
			$PlayerSprite.flip_h=true
	
	#kibbord
	else:
		isMouse = false
		if Input.is_action_pressed("moveRight"):
			velocity.x += 1
			$PlayerSprite.flip_h = false
		if Input.is_action_pressed("moveLeft"):
			velocity.x -= 1
			$PlayerSprite.flip_h = true
		if Input.is_action_pressed("moveDown"):
			velocity.y += 1
		if Input.is_action_pressed("moveUp"):
			velocity.y -= 1
		velocity = velocity.normalized()*speed
	

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)