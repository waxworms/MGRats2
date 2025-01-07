extends Area2D

func _ready():
	SignalBus.connect("playerEnteredDoorLeft", self, "_on_playerHasLeft_L")

func _on_PlayMinigameButt_button_up():
	get_tree().change_scene("res://Minigame/minigameMainMenu.tscn")

func _on_GamingAreaScene_body_entered(body:KinematicBody2D):
	if body.name=="Player":
		SignalBus.emit_signal("playerEnteredDoorRight")

func _on_playerHasLeft_R():
	$CollisionShape2D.disabled = true

func _on_GamingAreaScene_body_exited(body:KinematicBody2D):
	if body.name=="Player":
		$CollisionShape2D.disabled = false
