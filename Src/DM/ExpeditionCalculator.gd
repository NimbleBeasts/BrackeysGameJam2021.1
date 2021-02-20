extends Node
class_name ExpeditionCalculator

var gg : GridGetter = Types.grid_getter

#Determine how much resources cost to perform the expedition.
var current_location : PoolVector2Array = PoolVector2Array()
var traveled : PoolRealArray = PoolRealArray()

var current_food_cost : int = 0
var current_water_cost : int = 0

var reward_food : PoolIntArray = PoolIntArray()
var reward_water : PoolIntArray = PoolIntArray()

func _init():
	Types.resources_getter.expedition_calc = self

func _ready():
	if not Events.is_connected(Events.GATHER_POINT_ADDED, self, "point_added") :
		var home_base = gg.get_home_base_pos()
		current_location.append(Vector2(home_base)) #Default value for starting spot.
		traveled.append(0)
		Events.connect(Events.GATHER_POINT_ADDED, self, "point_added")
		Events.connect(Events.GATHER_POINT_REMOVED, self, "point_removed")
		Events.connect(Events.EXPEDITION_STARTED, self, "clear")
		Events.connect(Events.EXPEDITION_CANCELLED, self, "clear")

#Reset myself to zero.
func clear() -> void :
	current_location = PoolVector2Array()
	var home_base : Vector2 = gg.get_home_base_pos()
	current_location.append(home_base) #Default value for starting spot.
	traveled = PoolRealArray()
	traveled.append(0)
	current_food_cost = 0
	current_water_cost = 0
	Events.emit_signal(Events.GATHER_POINT_CALCULATED, current_food_cost, current_water_cost)

func point_added(spot : GatheringSpot) -> void :
	var loc : Vector2 = current_location[current_location.size() - 1]
	traveled.append(traveled[traveled.size() - 1] + loc.distance_to(spot.location_in_grid))
	current_location.append(spot.location_in_grid)
	
	#Determine how much food and water that costs.
	var trav : float = traveled[traveled.size()-1]
	current_food_cost = int(round(trav * 1.6))
	current_water_cost = int(round(trav * 1.8))
	
	var a : int = 0
	if reward_food.size() > 0 :
		a = reward_food[reward_food.size() - 1]
	var spot_rewards : Dictionary = spot.get_reward()
	reward_food.append(a + spot_rewards["food"])
	
	var b : int = 0
	if reward_water.size() > 0 :
		b = reward_water[reward_water.size() - 1]
	reward_water.append(b + spot_rewards["water"])
	
	Events.emit_signal(Events.GATHER_POINT_CALCULATED, current_food_cost, current_water_cost)

func point_removed() -> void :
	if traveled.size() == 1 || current_location.size() == 1:
		return
	traveled.remove(traveled.size() - 1)
	current_location.remove(current_location.size() - 1)
	
	reward_food.remove(reward_food.size() - 1)
	reward_water.remove(reward_water.size() - 1)

func project_cost(unit_count : int) -> Dictionary :
	var day_cost : int = int(round(traveled[traveled.size()-1] * 1))
	if day_cost <= 0 :
		day_cost = 1
	var cost : Dictionary = {
		"food" : current_food_cost * unit_count,
		"water" : current_water_cost * unit_count,
		"day_cost": day_cost
	}
	Events.emit_signal(Events.GATHER_POINT_PROJECTED, cost)
	return cost

func project_reward() -> Dictionary :
	var rewards : Dictionary = {
		"food" : reward_food[reward_food.size() - 1],
		"water" : reward_water[reward_water.size() - 1]
	}
	return rewards
