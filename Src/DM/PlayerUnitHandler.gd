extends Node

#How many units you have in total.
var unit_count : int = 20 setget ,get_unit_count

#How many units you have that are not occupied.
var available_units : int = 20

#Listen for units being added.
var already_ready : bool = false
func _ready() -> void :
	if not already_ready :
		already_ready = true
		Events.connect(Events.ADD_UNIT, self, "add_unit")

func add_unit() -> void :
	unit_count += 1
	available_units += 1

func get_unit_count() -> int :
	return unit_count

#Return number of units not away from camp. Either available or sleeping.
func get_units_present() -> int :
	return available_units
