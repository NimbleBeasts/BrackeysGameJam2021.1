extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect(Events.FOOD_CHANGED, self, "set_food")
	
func set_food(food_value : int) -> void :
	text = str(food_value)
