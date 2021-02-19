extends DiceRoll

#If all units return then you gain some faith.
var potential_units_return : int = 0

var potential_food_return : int = 0
var potential_water_return : int = 0

func roll_chances() -> int :
	return 2
