extends Area2D
signal playerEntered

func _on_PortalLobby_body_entered(body: KinematicBody2D):
	if body.name=="Player":
		emit_signal("playerEntered")