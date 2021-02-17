extends Label

const TEXT = "Cost Below:\nFood - %s\nWater - %s"

func _ready():
	if not Events.is_connected(Events.GATHER_POINT_PROJECTED, self, "cost") :
		Events.connect(Events.GATHER_POINT_PROJECTED, self, "cost")

func cost(food : int, water : int) -> void :
	text = TEXT % [str(food), str(water)]
