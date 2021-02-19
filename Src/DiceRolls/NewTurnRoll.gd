extends DiceRoll
class_name NewTurnRoll


func _init() -> void :
	day_cost = -1
	use_key = Data.getEventIdByName(Types.EventTypes.TurnRandom, "swordbread")
