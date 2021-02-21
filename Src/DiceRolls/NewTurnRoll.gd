extends DiceRoll
class_name NewTurnRoll

var eg : EventsGetter = Types.events_getter


func _init() -> void :
	day_cost = -1

func roll_chances() -> int :
	var possible_events : Array = Data.events["turnRandom"]
	
	#2 out of 5 nothing happens.
	var chances : int = (randi() % (possible_events.size() + 4)) - 4
	if chances < 0 :
		return 1
	if chances >= possible_events.size() :
		chances = possible_events.size() - 1
	eg.set_event(possible_events[chances])
	Events.emit_signal("window_show", Types.WindowType.Event, {"eventType": Types.EventTypes.TurnRandom, "id":  chances})
	
	return 0
