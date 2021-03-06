extends Node
class_name DiceRoll

"""
 This class handles the likelyhood of dice events succeeding.
"""

signal removed(diceroll_dice_roll)

#How many days before rolling will happen.
#If negative one, then dice roll will always be present.
var day_cost : int = 1 setget ,get_day_cost

var use_key : int = -1

func decrement_day() -> void :
	day_cost -= 1
	if day_cost < 0 :
		day_cost = -1

func get_day_cost() -> int :
	return day_cost

func is_permanent() -> bool :
	if day_cost <= -1 :
		day_cost = -1
		return true
	else :
		return false

func remove() -> void :
	emit_signal("removed", self)

func roll() -> void :
	#Inheriting classes will use this to roll on each turn.
	# warning-ignore:return_value_discarded
	roll_chances()

func roll_chances() -> int :
	return randi() % 2

func roll_and_free() -> void :
	roll()
	queue_free()

func set_day_cost(days : int) -> void :
	day_cost = days
