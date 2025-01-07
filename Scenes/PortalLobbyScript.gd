extends Area2D

func _on_PortalLobby_body_entered(body: KinematicBody2D):
	if body.name=="Player":
		SignalBus.emit_signal("playerEnteredDoorLeft")

