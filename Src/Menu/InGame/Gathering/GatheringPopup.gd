extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect(Events.EXPEDITION_STARTED, self, "popup")
	Events.connect(Events.EXPEDITION_CANCELLED, self, "inverse_popup")

func inverse_popup() -> void :
	self.hide()

func popup() -> void :
	self.show()
