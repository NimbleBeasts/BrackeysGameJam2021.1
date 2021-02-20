extends DiceRoll
class_name ExpeditionsRoll

#What I import.
var ug : UnitGetter = Types.unit_getter
var rg : ResourcesGetter = Types.resources_getter


"""
 This contains all values for the expedition.
"""
#If all units return then you gain some faith.
var units_on_expedition : Array = []

var food_return : int = 0
var water_return : int = 0

#Kill units on expedition player leaves.
func _init():
	Events.connect(Events.LEFT_LOCATION, self, "kill_units")

func kill_units() -> void :
	ug.kill_units(units_on_expedition)

func roll_chances() -> int :
	rg.gift_food(food_return)
	rg.gift_water(water_return)
	ug.kill_units(units_on_expedition)
	return 0

func start() -> void :
	units_on_expedition = ug.retrieve_temp_slotted_units()
	var cost : Dictionary = rg.project_cost(units_on_expedition.size())
	rg.use_food(cost["food"])
	rg.use_water(cost["water"])
	
	#Now start the dice roll.
	day_cost = cost["day_cost"]
	Events.emit_signal(Events.DICE_ROLL_CREATED, self)
