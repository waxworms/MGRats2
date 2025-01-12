extends Camera2D

func _ready():
	SignalBus.connect("playerEnteredDoorLeft", self, "_on_playerEnteredDoorLeft")
	SignalBus.connect("playerEnteredDoorUp", self, "_on_playerEnteredDoorUp")


func _on_playerEnteredDoorLeft():
	self.make_current()

func _on_playerEnteredDoorUp():
	self.make_current()

func _on_ParentMapScene_initiateCam():
	self.make_current()
