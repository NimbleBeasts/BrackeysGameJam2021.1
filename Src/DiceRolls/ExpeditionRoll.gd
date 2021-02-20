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
	Events.connect(Events.LEFT_LOCATION, self, "kill_all_units")

func kill_all_units() -> void :
	ug.kill_units(units_on_expedition)
	remove()

func roll_chances() -> int :
	var chances : int = randi() % (units_on_expedition.size() + 1)
	#Kill random units in the party.
	var kill : Array = []
	var kill_uid : Array = []
	while chances > 0 :
		var random = randi() % units_on_expedition.size()
		var unit : Unit = units_on_expedition[random]
		kill.append(unit)
		units_on_expedition.remove(random)
		
		kill_uid.append(unit.uid)
		
		chances -= 1
	
	var data = {
		"eventType": Types.EventTypes.Gameplay,
		"payload": {
			"success": false,
			"changes": {
				"water": 0,
				"faith": 0,
				"food": 0
			},
			"casualties": [kill_uid] #array of uids
		},
		"id": Data.getEventIdByName(Types.EventTypes.Gameplay, "on_expedition_end")
		}
	
	if kill.size() > 0 :
		ug.kill_units(kill)
	
	if units_on_expedition.size() > 0 :
		rg.gift_food(food_return)
		rg.gift_water(water_return)
		ug.return_units(units_on_expedition)
		data["payload"]["changes"]["water"] = water_return
		data["payload"]["changes"]["food"] = food_return
		data["payload"]["success"] = true

	Events.emit_signal("window_show", Types.WindowType.Event, data)
	return 0

func start() -> void :
	units_on_expedition = ug.retrieve_temp_slotted_units()
	var cost : Dictionary = rg.project_cost(units_on_expedition.size())
	rg.use_food(cost["food"])
	rg.use_water(cost["water"])
	day_cost = cost["day_cost"]
	
	#Get the rewards.
	var rewards : Dictionary = rg.project_reward()
	food_return = rewards["food"]
	water_return  = rewards["water"]
	
	Events.emit_signal(Events.DICE_ROLL_CREATED, self)
