extends Node2D

onready var time = 0.0

func _process(delta):
	time+=delta

func getTime():
	return time

func resetTime():
	time=0.0