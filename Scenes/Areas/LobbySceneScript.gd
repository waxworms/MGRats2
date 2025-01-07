extends Area2D

func _ready():
	SignalBus.connect("playerEnteredDoorRight", self, "_on_playerHasLeft_R")

func _on_GameScene_body_entered(body:KinematicBody2D):
	if body.name=="Player":
		SignalBus.emit_signal("playerEnteredDoorLeft")

func _on_playerHasLeft_R():
	$CollisionShape2D.disabled = true

func _on_GameScene_body_exited(body:KinematicBody2D):
	if body.name=="Player":
		$CollisionShape2D.disabled = false
#use set_deferred instead for monitoring/monitorable