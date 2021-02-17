extends Node


#Determine how much resources cost to perform the expedition.
var current_location : Vector2 = Vector2(0,0)
var traveled : float = 0

var current_food_cost : int = 0
var current_water_cost : int = 0

func _ready():
	if not Events.is_connected(Events.GATHER_POINT_ADDED, self, "point_added") :
		Events.connect(Events.GATHER_POINT_ADDED, self, "point_added")
		Events.connect(Events.EXPEDITION_CONFIRMED, self, "clear")

#Reset myself to zero.
func clear() -> void :
	current_location = Vector2(-1,-1)
	traveled = 0
	current_food_cost = 0
	current_water_cost = 0
	Events.emit_signal(Events.GATHER_POINT_CALCULATED, current_food_cost, current_water_cost)

func point_added(spot : GatheringSpot) -> void :
	traveled += current_location.distance_to(spot.location_in_grid)
	
	#Determine how much food and water that costs.
	current_food_cost = int(round(traveled * 1.2))
	current_water_cost = int(round(traveled * 1.4))
	
	Events.emit_signal(Events.GATHER_POINT_CALCULATED, current_food_cost, current_water_cost)
