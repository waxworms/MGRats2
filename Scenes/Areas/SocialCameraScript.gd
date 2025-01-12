extends Camera2D

func _ready():
	SignalBus.connect("playerEnteredDoorDown", self, "_on_playerEnteredDoorDown")

func _on_playerEnteredDoorDown():
	self.make_current()
