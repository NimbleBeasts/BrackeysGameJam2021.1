extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect(Events.FAITH_CHANGED, self, "faith_changed")

func faith_changed(faith_value : int) -> void :
	text = str(faith_value)
