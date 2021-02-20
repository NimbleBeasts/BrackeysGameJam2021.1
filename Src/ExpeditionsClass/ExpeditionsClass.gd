extends DiceRoll
class_name ExpeditionsRoll

#What I import.
var ug : UnitGetter = Types.unit_getter
var rg : ResourcesGetter = Types.resources_getter

var units : int = 0



"""
 This contains all values for the expedition.
"""


func start() -> void :
	units = ug.retrieve_temp_slotted_units()
	var cost : Dictionary = rg.project_cost(units)
	rg.use_food(cost["food"])
	rg.use_water(cost["water"])
	
	#Now start the dice roll.
	day_cost = cost["day_cost"]
	Events.emit_signal(Events.DICE_ROLL_CREATED, self)
