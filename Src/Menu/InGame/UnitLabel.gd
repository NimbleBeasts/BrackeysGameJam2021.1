extends Label




func _ready():
	Events.connect(Events.UNIT_CHANGED, self, "unit_changed")

func unit_changed(value : int) -> void :
	text = str(value)
