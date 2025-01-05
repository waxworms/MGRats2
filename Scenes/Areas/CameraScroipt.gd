extends Node2D
onready var canvOrigin = get_canvas_transform().origin

func _on_PortalGameArea_playerEntered():
	print('boink')
