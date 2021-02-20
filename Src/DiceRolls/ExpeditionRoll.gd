extends DiceRoll
class_name ExpeditionsRoll

#What I import.
var ug : UnitGetter = Types.unit_getter
var rg : ResourcesGetter = Types.resources_getter

var units : int = 0



"""
 This contains all values for the expedition.
"""
#If all units return then you gain some faith.
var units_on_expedition : int = 0

var food_return : int = 0
var water_return : int = 0

func roll_chances() -> int :
	rg.gift_food(food_return)
	rg.gift_water(water_return)
	ug.gift_units(units_on_expedition)
	return 0

func start() -> void :
	units = ug.retrieve_temp_slotted_units()
	units_on_expedition = units
	var cost : Dictionary = rg.project_cost(units)
	rg.use_food(cost["food"])
	rg.use_water(cost["water"])
	
	#Now start the dice roll.
	day_cost = cost["day_cost"]
	Events.emit_signal(Events.DICE_ROLL_CREATED, self)
