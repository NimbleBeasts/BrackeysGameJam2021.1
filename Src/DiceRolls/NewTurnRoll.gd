extends DiceRoll
class_name NewTurnRoll


func _init() -> void :
	day_cost = -1

func roll_chances() -> int :
	var possible_events : Array = Data.events["turnRandom"]
	
	#2 out of 5 nothing happens.
	var chances : int = (randi() % (possible_events.size() + 4)) - 4
	if chances <= 0 :
		return 1
	Events.emit_signal("window_show", Types.WindowType.Event, {"eventType": Types.EventTypes.TurnRandom, "id":  chances})
#	Events.emit_signal(Events.WINDOW_SHOW, Types.WindowType.Event, possible_events[chances])
	return 0
