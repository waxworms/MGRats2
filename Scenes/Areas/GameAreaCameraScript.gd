extends Camera2D

func _ready():
	SignalBus.connect("playerEnteredDoorRight", self, "_on_playerEnteredDoorRight")

func _on_playerEnteredDoorRight():
	self.make_current()
