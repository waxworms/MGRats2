extends Area2D

func _on_PlayMinigameButt_button_up():
	get_tree().change_scene("res://Minigame/minigameMainMenu.tscn")

func _on_GamingAreaScene_body_entered(body:KinematicBody2D):
	if body.name=="Player":
		SignalBus.emit_signal("playerEnteredDoorRight")
