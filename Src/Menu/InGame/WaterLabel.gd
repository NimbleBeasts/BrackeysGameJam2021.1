extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect(Events.WATER_CHANGED, self, "set_water")

func set_water(water_value : int) -> void :
	text = str(water_value)
