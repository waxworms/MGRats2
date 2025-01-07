extends KinematicBody2D

export (int) var speed = 200
var velocity = Vector2()

onready var target = position

# func getInputType():
# 	if Input.is_action_pressed("moveRight") or Input.is_action_pressed("moveLeft") or Input.is_action_pressed("moveDown") or Input.is_action_pressed("moveUp"):
# 		keyboardVelocityCalc()

func keyboardVelocityCalc():

	velocity = Vector2()

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
	

func mouseVelocityCalc(givenTarget):
	velocity = Vector2()
	velocity = position.direction_to(givenTarget)*speed

	if velocity.x>0:
		$PlayerSprite.flip_h=false
	elif velocity.x<0:
		$PlayerSprite.flip_h=true

	_physics_process(get_physics_process_delta_time())

func _physics_process(_delta):
	keyboardVelocityCalc()
	velocity = move_and_slide(velocity)

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
	   mouseVelocityCalc(event.position)
