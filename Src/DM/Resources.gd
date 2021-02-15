extends Node

#How much a unit costs per turn in food and water.
export(int) var unit_faith_gained = 5
export(int) var unit_food_cost = 10
export(int) var unit_water_cost = 10

#The dungeon master has everything I need.
onready var dm : Node = get_parent()

var energy : int = 1000
var faith : int = 1000
var food : int = 1000
var water : int = 1000

func _ready():
	Events.connect(Events.TURN_ENDED, self, "_turn_ended")

#Calculate how much food is used based on unit amount.
func _turn_ended() -> void :
	#Subtract from water and food based on number of units.
	var units : int = dm.get_unit_count()
	food -= units * unit_food_cost
	water -= units * unit_water_cost
	
	#Add to faith based on resting and available units.
	var present = dm.get_units_present()
	faith += (unit_faith_gained * present) * 0.5
	
	print(str(food) + " " + str("water"))
	print(str(faith))

	
