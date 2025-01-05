extends Camera2D

func _ready():
	connect("moveToGamingArea", self, "_on_Events_moveToGamingArea")

func _on_Events_moveToGamingArea():
	print('boink')
