extends Node2D

export var menuMinigameScene : PackedScene

func _on_BackButt_button_up():
	get_tree().change_scene(menuMinigameScene.resource_path)