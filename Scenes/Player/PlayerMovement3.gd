extends KinematicBody2D

export (int) var speed = 256
var velocity = Vector2()

onready var target = Vector2(position.x-120, position.y)
var isMouse = true

func _ready():
	SignalBus.connect("playerEnteredDoorRight", self, "_on_enteredDoorRight")
	SignalBus.connect("playerEnteredDoorLeft", self, "_on_enteredDoorLeft")
	SignalBus.connect("playerEnteredDoorDown", self, "_on_enteredDoorDown")
	SignalBus.connect("playerEnteredDoorUp", self, "_on_enteredDoorUp")

func _on_enteredDoorRight():
	self.global_position.x += 120
	

func _on_enteredDoorLeft():
	self.global_position.x -= 120

func _on_enteredDoorDown():
	self.global_position.y +=200

func _on_enteredDoorUp():
	self.global_position.y -=200

func get_input():
	var movement_direction = Vector2()
	
	if Input.is_action_pressed("moveRight"):
		movement_direction.x += 1
	if Input.is_action_pressed("moveLeft"):
		movement_direction.x -= 1
	if Input.is_action_pressed("moveDown"):
		movement_direction.y += 1
	if Input.is_action_pressed("moveUp"):
		movement_direction.y -= 1
	
	if movement_direction != Vector2():
		isMouse = false
	elif Input.is_action_just_pressed("clicky"):
		target = get_global_mouse_position()
		isMouse = true
		movement_direction = position.direction_to(target)
	elif isMouse:
		movement_direction = position.direction_to(target)
	
	velocity = movement_direction.normalized()*speed
	if velocity.x>0:
		$PlayerSprite.flip_h=false
	elif velocity.x<0:
		$PlayerSprite.flip_h=true

func _physics_process(_delta):
	get_input()
	if isMouse:
		if position.distance_to(target)>2:
			velocity = move_and_slide(velocity)
	else:
		velocity = move_and_slide(velocity)