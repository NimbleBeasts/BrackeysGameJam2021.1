extends Node

#This class is in charge of rolling the dice for all the events.

var rolls : Array = []

func _ready() -> void :
	#Add the dice roll that happens each day.
	var roll : DiceRoll = NewTurnRoll.new()
	rolls.append(roll)
	
	Events.connect(Events.TURN_ENDED, self, "_turn_ended")

func _turn_ended() -> void :
	for roll in rolls :
		var dr : DiceRoll = roll
		
		if dr.is_permanent() :
			dr.roll()
		
		else :
			dr.decrement_day()
			if dr.get_day_cost() == 0:
				dr.roll_and_free() #Get what the roll costed.
		
