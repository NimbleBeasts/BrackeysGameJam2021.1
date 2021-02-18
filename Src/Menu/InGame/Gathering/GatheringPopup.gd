extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect(Events.EXPEDITION_STARTED, self, "popup")

func popup() -> void :
	self.show()
