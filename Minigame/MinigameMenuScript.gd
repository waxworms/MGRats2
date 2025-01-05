extends Node2D

func _on_PlayButt_button_up():
	get_tree().change_scene("res://Minigame/minigameMainGame.tscn")

func _on_HowToButt_button_up():
	get_tree().change_scene("res://Minigame/minigameHowTo.tscn")

func _on_QuitButt_button_up():
	get_tree().change_scene("res://Scenes/Areas/ParentMapScene.tscn")