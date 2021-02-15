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

#Calculate how much food is used based on unit amount.
func turn_end_test() -> bool :
	#Subtract from water and food based on number of units.
	var units : int = dm.get_unit_count()
	food -= units * unit_food_cost
	water -= units * unit_water_cost
	
	#Add to faith based on resting and available units.
	var present = dm.get_units_present()
	faith += (unit_faith_gained * present) * 0.5
	
	#Check that no resource is below 0.
	if food <= 0 || water <= 0 :
		return false
	
	#Let dungeon master know I am finished processing turn end.
	return true
