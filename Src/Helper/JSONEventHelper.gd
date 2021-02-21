extends Node
class_name JSONEventHelper

var rg : ResourcesGetter = Types.resources_getter
var ug : UnitGetter = Types.unit_getter

const ACTION = "action"
const CON = "consequences"
const TYPE = "type"

#These are what types the action could be.
const YESNO = "yesno"

#What types the consequence could be.
const PLAY = "play"
const JOIN = "join-select"
const SACRIFICE = "sacrifice"

const RESOURCE = "resources"

func handle_choice(event : Dictionary, yes_or_no : String) -> void :
	var con : Array = event[ACTION][yes_or_no][CON]
	handle_consequence(con)

func handle_consequence(con : Array) -> void :
	for result in con :
		match result[TYPE] :
			PLAY :
				handle_result_play(result["minigame"])
			
			JOIN :
				handle_result_join(result)
			
			SACRIFICE :
				handle_result_sacrifice(result)
			
			RESOURCE :
				handle_result_resource(result)

func handle_result_join(result : Dictionary) -> void :
	#Randomize who we get for now.
	var small : int = result["min-amount-available"]
	var large : int = result["max-amount-available"]
	var ran : int = (randi() % (large - (small - 1))) + small
	for _i in range(small, large) :
		ug.add_unit_by_chance()

#Only dice minigames for now.
func handle_result_play(minigame : Dictionary) -> void :
	var roll : int = (randi() % 6) + 1
	if roll >= minigame["win-min-score"] :
		handle_consequence(minigame["win-consequences"])
	else :
		handle_consequence(minigame["lose-consequences"])

func handle_result_resource(result : Dictionary) -> void :
	rg.gift_faith(result["faith"])
	rg.gift_food(result["food"])
	rg.gift_water(result["water"])

func handle_result_sacrifice(result : Dictionary) -> void :
	Events.emit_signal("window_show", Types.WindowType.Char, Types.CharEventType.Sacrifice)

func get_choice(yes_or_no : String) -> void :
	pass
