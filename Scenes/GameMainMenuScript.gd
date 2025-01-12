extends Node2D

func _on_LogInButt_button_up():
	get_tree().change_scene('res://Scenes/Menu/GameLogInScene.tscn')


func _on_RegisterButt_button_up():
	get_tree().change_scene("res://Scenes/Menu/GameRegisterScene.tscn")