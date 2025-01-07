extends Node2D
signal initiateCam

func _ready():
	emit_signal('initiateCam')