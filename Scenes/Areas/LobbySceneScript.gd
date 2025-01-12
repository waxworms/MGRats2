extends Area2D

func _on_GameScene_body_entered(body:KinematicBody2D):
	if body.name=="Player":
		if body.position.y<=384:
			SignalBus.emit_signal("playerEnteredDoorLeft")
		else:
			SignalBus.emit_signal("playerEnteredDoorUp")