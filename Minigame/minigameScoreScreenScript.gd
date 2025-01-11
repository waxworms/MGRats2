extends Node2D

onready var scoreCont = get_node("MarginContainer/ScoreColumnContainer/ScoreLabel")
onready var coinCont = get_node("MarginContainer/ScoreColumnContainer/CoinsEarnedLabel")

func _ready():
	scoreCont.text = "Score: "+str(MinigameGlobals.playerScore)
	coinCont.text = "Coins earned: "+str(MinigameGlobals.coinsEarned)


func _on_MainGameButton_button_up():
	get_tree().change_scene("res://Scenes/Areas/ParentMapScene.tscn")
